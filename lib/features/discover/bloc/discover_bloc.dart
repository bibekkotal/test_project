import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_project/utils/app_exports.dart';
import 'package:test_project/utils/colorful_log.dart';
part 'discover_events.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(DiscoverState(selectedBottomTabIndex: 0)) {
    on<ChangeBottomTabIndexEvent>(_changeBottomTabIndex);
  }

  Future<void> _changeBottomTabIndex(
      ChangeBottomTabIndexEvent event, Emitter<DiscoverState> emit) async {
    emit(state.copyWith(selectedBottomTabIndex: event.index));
    if (event.index == 2) NavigatorService.pushNamed(RouteNames.booking);
  }
}
