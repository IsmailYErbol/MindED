part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  List myLikes;
  List myPosts;
  String myId;
  String myAge;
  String myClass;
  String myName;
  ProfileLoaded(
      {required this.myLikes,
      required this.myPosts,
      required this.myId,
      required this.myAge,
      required this.myName,
      required this.myClass});
}
