part of 'mood_tracker_bloc.dart';

@immutable
sealed class MoodTrackerState {}

final class MoodTrackerInitial extends MoodTrackerState {}

class MoodTrackerLoaded extends MoodTrackerState {
  final data;
  int selectedMood;
  int selectedDate;
  final dates;
  MoodTrackerLoaded(
      {required this.data,
      required this.dates,
      required this.selectedMood,
      required this.selectedDate});
}
