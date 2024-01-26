import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/screens/functions/functions.dart';
import 'package:minded_hub/screens/profile/bloc/profile_bloc.dart';

class CommentsBottomSheet extends StatelessWidget {
  final data;
  final commentId;
  final state;
  CommentsBottomSheet(
      {super.key,
      required this.data,
      required this.commentId,
      required this.state});
  @override
  Widget build(BuildContext context) {
    TextEditingController comment = TextEditingController();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state2) {
          if (state2 is ProfileLoaded) {
            return Container(
              height: 600,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Comments',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(),
                        (data.length != 0)
                            ? Column(
                                children: data.map<Widget>((e) {
                                  String date = HelperFunctions()
                                      .formatTimestamp(e['date']);
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text(e['name']
                                          .toString()
                                          .split('')[0]
                                          .toUpperCase()),
                                    ),
                                    title: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          e['name'].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          date.toString(),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      ],
                                    ),
                                    subtitle: Text(e['comment'].toString()),
                                  );
                                }).toList(),
                              )
                            : Center(
                                child: Text('No comments...'),
                              )

                        // Add more ListTile widgets for additional comments
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: comment,
                                style: TextStyle(
                                  backgroundColor:
                                      Color.fromRGBO(118, 118, 128, 0.35),
                                ),
                                decoration: InputDecoration(
                                  hintText: "Write comment",
                                  filled: true,
                                  fillColor: Color.fromRGBO(235, 235, 245, 0.6),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            InkWell(
                                onTap: () async {
                                  Map<String, dynamic> dataToAdd = {
                                    'comment': comment.text,
                                    'date': Timestamp.now(),
                                    'userId': state2.myId,
                                    'name': state2.myName,
                                  };

                                  state(() {
                                    data.add(dataToAdd);
                                  });

                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('post')
                                        .doc(commentId)
                                        .update({
                                      'comments':
                                          FieldValue.arrayUnion([dataToAdd]),
                                    });
                                    print('Comment added successfully!');
                                    comment
                                        .clear(); // Clear the comment text field
                                  } catch (e) {
                                    print('Error adding comment: $e');
                                  }
                                },
                                child: Icon(Icons.send)),
                          ],
                        ),
                      ))
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
