import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../navigation/route_names.dart';
import '../../../utils/colorful_log.dart';
import '../../../utils/navigator_service.dart';
part 'home_events.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeState(
          weekDates: [],
          selectedIndex: 0,
          selectedBottomTabIndex: 0,
        )) {
    on<GenerateWeekDatesEvent>(_generateWeekDates);
    on<SelectDateEvent>(_selectDate);
    on<ChangeBottomTabIndexEvent>(_changeBottomTabIndex);
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
  }

  Future<void> _selectDate(
    SelectDateEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(selectedIndex: event.index));
  }

  Future<void> _changeBottomTabIndex(
    ChangeBottomTabIndexEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(selectedBottomTabIndex: event.index));

    if (event.index == 1) NavigatorService.pushNamed(RouteNames.discover);
  }
}
