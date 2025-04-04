part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<DateTime> weekDates;
  final int selectedIndex;
  final int selectedBottomTabIndex;

  HomeState({
    required this.weekDates,
    required this.selectedIndex,
    required this.selectedBottomTabIndex,
  });

  HomeState copyWith({
    List<DateTime>? weekDates,
    int? selectedIndex,
    int? selectedBottomTabIndex,
  }) {
    return HomeState(
      weekDates: weekDates ?? this.weekDates,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedBottomTabIndex:
          selectedBottomTabIndex ?? this.selectedBottomTabIndex,
    );
  }

  @override
  List<Object?> get props => [weekDates, selectedIndex, selectedBottomTabIndex];
}
