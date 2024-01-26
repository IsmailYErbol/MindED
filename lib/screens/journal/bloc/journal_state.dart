part of 'journal_bloc.dart';

@immutable
sealed class JournalState {}

final class JournalInitial extends JournalState {}

class JournalLoaded extends JournalState {
  var data;
  JournalLoaded({required this.data});
}
