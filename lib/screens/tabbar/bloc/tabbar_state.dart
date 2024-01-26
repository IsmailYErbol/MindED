part of 'tabbar_bloc.dart';

@immutable
sealed class TabbarState {}

final class TabbarInitial extends TabbarState {}

class TabbarLoaded extends TabbarState {
  List screens = [];
  int index = 0;
  TabbarLoaded({required this.screens, required this.index});
}
