import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/screens/functions/functions.dart';
import 'package:minded_hub/screens/mood_tracker/bloc/mood_tracker_bloc.dart';
import 'package:minded_hub/screens/mood_tracker/components/mood_information.dart';
import 'package:minded_hub/screens/mood_tracker/components/mood_tracker_add.dart';

class MoodTrackerScreen extends StatelessWidget {
  MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Mood Tracker",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => MoodTrackerAddScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<MoodTrackerBloc, MoodTrackerState>(
        builder: (context, state) {
          if (state is MoodTrackerLoaded) {
            String formattedDate = HelperFunctions().getCurrentDateFormatted();

            return SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          BlocProvider.of<MoodTrackerBloc>(context)
                              .add(MoodTrackerChangeDate(isForward: 0));
                        },
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        state.dates[state.selectedDate],
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<MoodTrackerBloc>(context)
                              .add(MoodTrackerChangeDate(isForward: 1));
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                (state.data.length == 0)
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('No Data'),
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children:
                            state.data[state.selectedDate].map<Widget>((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: MoodInformationCard(
                            data: e,
                          ),
                        );
                      }).toList())
              ]),
            ));
          }
          return Container(
            child: Text('NOT LOADED'),
          );
        },
      ),
    );
  }
}
