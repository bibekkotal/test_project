part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<DateTime> weekDates;
  final int selectedIndex;
  final int selectedBottomTabIndex;
  final bool isLoading;
  final AllUserPlansData? userPlansData;

  HomeState({
    required this.weekDates,
    required this.selectedIndex,
    required this.selectedBottomTabIndex,
    this.isLoading = false,
    this.userPlansData,
  });

  HomeState copyWith({
    List<DateTime>? weekDates,
    int? selectedIndex,
    int? selectedBottomTabIndex,
    bool? isLoading,
    AllUserPlansData? userPlansData,
  }) {
    return HomeState(
      weekDates: weekDates ?? this.weekDates,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedBottomTabIndex:
          selectedBottomTabIndex ?? this.selectedBottomTabIndex,
      isLoading: isLoading ?? this.isLoading,
      userPlansData: userPlansData ?? this.userPlansData,
    );
  }

  @override
  List<Object?> get props => [
        weekDates,
        selectedIndex,
        selectedBottomTabIndex,
        isLoading,
        userPlansData,
      ];
}
