import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minded_hub/screens/functions/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc() : super(JournalInitial()) {
    var data = [];

    on<JournalEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (event is JournalLoad) {
        if (prefs.getString("localJournals") == null) {
          emit(JournalLoaded(data: data));
        } else {
          final List list1 =
              jsonDecode(prefs.getString("localJournals").toString());
          print(list1);
          data = list1;
          emit(JournalLoaded(data: data));
        }
      }
      if (event is JournalAdd) {
        String formattedDate = HelperFunctions().getCurrentDateFormatted();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final List list1 =
            jsonDecode(prefs.getString("localJournals").toString()) ?? [];
        list1.add({
          "title": event.title,
          "description": event.description,
          'date': formattedDate
        });
        data = list1;
        print(data);
        final jsonData = jsonEncode(list1);
        await prefs.setString("localJournals", jsonData);
        emit(JournalLoaded(data: data));
      }
    });
  }
}
