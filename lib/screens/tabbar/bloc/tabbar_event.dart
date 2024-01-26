part of 'tabbar_bloc.dart';

@immutable
sealed class TabbarEvent {}

class TabbarLoad extends TabbarEvent {}

class TabbarChangePage extends TabbarEvent {
  int index;
  TabbarChangePage({required this.index});
}

class TabbarLogChangePage extends TabbarEvent {
  int index;
  TabbarLogChangePage({required this.index});
}
