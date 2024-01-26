import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/components/custom_button.dart';
import 'package:minded_hub/components/custom_snackbar.dart';

import 'package:minded_hub/screens/mood_tracker/bloc/mood_tracker_bloc.dart';
import 'package:minded_hub/screens/mood_tracker/components/mood_card.dart';

class MoodTrackerAddScreen extends StatelessWidget {
  const MoodTrackerAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController note = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<MoodTrackerBloc>(context).add(MoodTrackerLoad());
              Navigator.pop(context, true);
            }),
        title: Text(
          "Add",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<MoodTrackerBloc, MoodTrackerState>(
          builder: (context, state) {
            if (state is MoodTrackerLoaded) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'How are you feeling?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<MoodTrackerBloc>(context)
                                .add(MoodTrackerSelectMood(index: 0));
                          },
                          child: MoodCard(
                              isSelected:
                                  (state.selectedMood == 0) ? true : false,
                              iconUrl: 'https://i.ibb.co.com/Bg2c4h4/2.png',
                              text: 'Awful'),
                        ),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<MoodTrackerBloc>(context)
                                .add(MoodTrackerSelectMood(index: 1));
                          },
                          child: MoodCard(
                              isSelected:
                                  (state.selectedMood == 1) ? true : false,
                              iconUrl: 'https://i.ibb.co.com/pJngz1K/1.png',
                              text: 'Sad'),
                        ),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<MoodTrackerBloc>(context)
                                .add(MoodTrackerSelectMood(index: 2));
                          },
                          child: MoodCard(
                              isSelected:
                                  (state.selectedMood == 2) ? true : false,
                              iconUrl: 'https://i.ibb.co.com/2s67NYD/3.png',
                              text: 'Normal'),
                        ),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<MoodTrackerBloc>(context)
                                .add(MoodTrackerSelectMood(index: 3));
                          },
                          child: MoodCard(
                              isSelected:
                                  (state.selectedMood == 3) ? true : false,
                              iconUrl: 'https://i.ibb.co.com/G0yqdJT/4.png',
                              text: 'Good'),
                        ),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<MoodTrackerBloc>(context)
                                .add(MoodTrackerSelectMood(index: 4));
                          },
                          child: MoodCard(
                              isSelected:
                                  (state.selectedMood == 4) ? true : false,
                              iconUrl: 'https://i.ibb.co.com/qprBWPp/5.png',
                              text: 'Awesome'),
                        ),
                      ],
                    ),
                    Text('Note',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: note,
                        maxLines: 20,
                        decoration: InputDecoration().copyWith(
                          // alternatively UnderlineInputBorder(),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        BlocProvider.of<MoodTrackerBloc>(context)
                            .add(MoodTrackerAdd(note: note.text));
                        CustomSnackbar()
                            .showCustomSnackBar(context, 'Successfully added!');
                      },
                      child: CustomButton(
                        title: 'Add',
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
