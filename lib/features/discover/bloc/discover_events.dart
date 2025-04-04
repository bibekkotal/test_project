part of 'discover_bloc.dart';

abstract class DiscoverEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeBottomTabIndexEvent extends DiscoverEvent {
  final int index;

  ChangeBottomTabIndexEvent(this.index);

  @override
  List<Object?> get props => [index];
}
