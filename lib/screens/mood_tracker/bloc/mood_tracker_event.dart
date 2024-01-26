part of 'mood_tracker_bloc.dart';

@immutable
sealed class MoodTrackerEvent {}

class MoodTrackerLoad extends MoodTrackerEvent {}

class MoodTrackerAdd extends MoodTrackerEvent {
  String note;
  MoodTrackerAdd({required this.note});
}

class MoodTrackerSelectMood extends MoodTrackerEvent {
  int index;
  MoodTrackerSelectMood({required this.index});
}

class MoodTrackerChangeDate extends MoodTrackerEvent {
  int isForward;
  MoodTrackerChangeDate({required this.isForward});
}
