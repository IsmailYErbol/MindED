import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:minded_hub/screens/functions/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'mood_tracker_event.dart';
part 'mood_tracker_state.dart';

class MoodTrackerBloc extends Bloc<MoodTrackerEvent, MoodTrackerState> {
  MoodTrackerBloc() : super(MoodTrackerInitial()) {
    var data = [];
    var dates = [];
    int selectedDate = 0;
    int selectedMood = -1;
    bool haveUntil = false;
    bool haveAfter = false;
    on<MoodTrackerEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (event is MoodTrackerLoad) {
        String formattedDate = HelperFunctions().getCurrentDateFormatted();

        if (prefs.getString("localMoodTracker") == null) {
          dates = [formattedDate];
          data = [];
          emit(MoodTrackerLoaded(
              data: data,
              dates: dates,
              selectedMood: selectedMood,
              selectedDate: selectedDate));
        } else {
          //list1

          var list1 =
              jsonDecode(prefs.getString("localMoodTracker").toString());

          bool isTodayExist = false;
          bool isTodayData = false;
          for (var i = 0; i < list1.length; i++) {
            dates.add(list1[i]['date']);
            data.add(list1[i]['data']);
            if (list1[i]['date'] == formattedDate) {
              selectedDate = i;
              isTodayExist = true;
            }
          }
          if (isTodayExist == false) {
            selectedDate = dates.length;
            dates.add(formattedDate);
            data.add([]);
          }

          emit(MoodTrackerLoaded(
              data: data,
              dates: dates,
              selectedMood: selectedMood,
              selectedDate: selectedDate));
        }
        emit(MoodTrackerLoaded(
            data: data,
            selectedMood: selectedMood,
            dates: dates,
            selectedDate: selectedDate));
      }
      if (event is MoodTrackerSelectMood) {
        selectedMood = event.index;
        emit(MoodTrackerLoaded(
            data: data,
            dates: dates,
            selectedMood: selectedMood,
            selectedDate: selectedDate));
      }
      if (event is MoodTrackerAdd) {
        DateTime now = DateTime.now();
        String formattedTime = DateFormat('HH:mm').format(now);

        String formattedDate = HelperFunctions().getCurrentDateFormatted();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final List list1 =
            jsonDecode(prefs.getString("localMoodTracker").toString()) ?? [];
        bool isExist = false;
        int existIndex = -1;
        for (var i = 0; i < list1.length; i++) {
          if (list1[i]['date'] == formattedDate) {
            isExist = true;
            existIndex = i;
          }
        }
        if (isExist) {
          list1[existIndex]['data'].add({
            "note": event.note,
            "mood": selectedMood,
            'time': formattedTime,
          });
        } else {
          list1.add({
            'date': formattedDate,
            'data': [
              {
                "note": event.note,
                "mood": selectedMood,
                'time': formattedTime,
              }
            ]
          });
        }
        final jsonData = jsonEncode(list1);
        await prefs.setString("localMoodTracker", jsonData);
        data[existIndex].add({
          "note": event.note,
          "mood": selectedMood,
          'time': formattedTime,
        });

        emit(MoodTrackerLoaded(
            data: data,
            dates: dates,
            selectedMood: selectedMood,
            selectedDate: selectedDate));
      }
      if (event is MoodTrackerChangeDate) {
        if (selectedDate > 0 && event.isForward == 0) {
          selectedDate = selectedDate - 1;
        } else {
          if (selectedDate < dates.length - 1) {
            selectedDate + 1;
          }
        }
        emit(MoodTrackerLoaded(
            data: data,
            dates: dates,
            selectedMood: selectedMood,
            selectedDate: selectedDate));
      }
    });
  }
}
// [23,24,25,26,27,28]
