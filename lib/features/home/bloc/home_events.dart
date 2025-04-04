part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenerateWeekDatesEvent extends HomeEvent {}

class SelectDateEvent extends HomeEvent {
  final int index;

  SelectDateEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ChangeBottomTabIndexEvent extends HomeEvent {
  final int index;

  ChangeBottomTabIndexEvent(this.index);

  @override
  List<Object?> get props => [index];
}
