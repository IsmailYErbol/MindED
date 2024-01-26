part of 'journal_bloc.dart';

@immutable
sealed class JournalEvent {}

class JournalLoad extends JournalEvent {}

class JournalAdd extends JournalEvent {
  String title;
  String description;
  JournalAdd({required this.title, required this.description});
}
