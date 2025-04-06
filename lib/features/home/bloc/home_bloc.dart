import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/plan_response.dart';
import '../../../navigation/route_names.dart';
import '../../../repositories/plan_repositories.dart';
import '../../../utils/app_exports.dart';
import '../../../utils/colorful_log.dart';
import '../../../utils/navigator_service.dart';
part 'home_events.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PlanRepositories _planRepositories;
  HomeBloc(this._planRepositories)
      : super(HomeState(
          weekDates: [],
          selectedIndex: 0,
          selectedBottomTabIndex: 0,
        )) {
    on<GenerateWeekDatesEvent>(_generateWeekDates);
    on<SelectDateEvent>(_selectDate);
    on<ChangeBottomTabIndexEvent>(_changeBottomTabIndex);
    on<GetPlansByDateEvent>(_getPlansByDate);
    on<AddOrUpdatePlansEvent>(_addOrUpdatePlans);
    on<SendUpdatePlansEvent>(_sendUpdatePlans);
    add(GenerateWeekDatesEvent());
  }

  Future<void> _generateWeekDates(
    GenerateWeekDatesEvent event,
    Emitter<HomeState> emit,
  ) async {
    DateTime today = DateTime.now();
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday % 7));
    List<DateTime> weekDates =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    int selectedIndex = weekDates.indexWhere((date) =>
        date.day == today.day &&
        date.month == today.month &&
        date.year == today.year);
    if (selectedIndex == -1) selectedIndex = 0;

    emit(state.copyWith(weekDates: weekDates, selectedIndex: selectedIndex));

    String formattedDate =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    add(GetPlansByDateEvent(formattedDate));
  }

  Future<void> _selectDate(
    SelectDateEvent event,
    Emitter<HomeState> emit,
  ) async {
    DateTime selectedDate = state.weekDates[event.index];
    String formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    add(GetPlansByDateEvent(formattedDate));
    emit(state.copyWith(selectedIndex: event.index));
  }

  Future<void> _changeBottomTabIndex(
    ChangeBottomTabIndexEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(selectedBottomTabIndex: event.index));
    if (event.index == 1) NavigatorService.pushNamed(RouteNames.discover);
  }

  Future<void> _getPlansByDate(
    GetPlansByDateEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _planRepositories.getAllPlanByDate(date: event.date);
    if (result.success && result.response!.data != null) {
      final data = AllUserPlansData.fromJson(result.response!.data!);
      emit(state.copyWith(userPlansData: data, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _sendUpdatePlans(
    SendUpdatePlansEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.weekDates.isEmpty) {
      add(GenerateWeekDatesEvent());
      Fluttertoast.showToast(
        msg: "Please try again in a moment",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.sp,
      );
      return;
    }

    if (state.selectedIndex < 0 ||
        state.selectedIndex >= state.weekDates.length) {
      ColorLog.cyan("Invalid selected index: ${state.selectedIndex}");
      return;
    }

    DateTime selectedDate = state.weekDates[state.selectedIndex];
    String formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

    final payload = AddUpdatePlanPayload(
      date: formattedDate,
      plans: [event.payload],
    );

    add(AddOrUpdatePlansEvent(
      date: formattedDate,
      payload: payload,
    ));
  }

  Future<void> _addOrUpdatePlans(
    AddOrUpdatePlansEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _planRepositories.addUpdatePlans(
      date: event.date,
      planDataPayload: event.payload,
    );

    emit(state.copyWith(isLoading: false));

    if (result.success) {
      final message =
          result.response?.data?['message'] ?? 'Plan updated successfully';

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.sp,
      );

      await Future.delayed(const Duration(milliseconds: 100));
      if (!isClosed) {
        add(GetPlansByDateEvent(event.date));
      }
    } else {
      final errorMsg =
          result.response?.data?['message'] ?? 'Failed to update plan';

      Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.sp,
      );
    }
  }
}
