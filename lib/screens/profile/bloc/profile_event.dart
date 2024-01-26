part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileLoad extends ProfileEvent {}

class ProfileLogOut extends ProfileEvent {}

class ProfileLogPagesChange extends ProfileEvent {
  int index;
  ProfileLogPagesChange({required this.index});
}
