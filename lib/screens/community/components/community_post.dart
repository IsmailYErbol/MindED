import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/components/custom_button.dart';
import 'package:minded_hub/components/custom_snackbar.dart';
import 'package:minded_hub/screens/functions/functions.dart';
import 'package:minded_hub/screens/profile/bloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityPostScreen extends StatelessWidget {
  const CommunityPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        title: Text(
          "Post",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Title',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                          controller: title,
                          decoration: InputDecoration().copyWith(
                            // alternatively UnderlineInputBorder(),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Description',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: description,
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
                        Map<String, dynamic> dataToAdd = {
                          'comments': [],
                          'likes': [],
                          'date': Timestamp.now(),
                          'postDescription': description.text,
                          'postTitle': title.text,
                          'userId': state.myId,
                          'userName': state.myName
                        };
                        String commentId = await HelperFunctions()
                            .addDocumentWithAutoIDAndField('post', dataToAdd);
                        try {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(state.myId)
                              .update({
                            'myPosts': FieldValue.arrayUnion([commentId]),
                          });
                          print(
                              'Data added to the document field successfully.');
                        } catch (e) {
                          print('Error adding data to the document field: $e');
                        }
                        CustomSnackbar()
                            .showCustomSnackBar(context, 'Successfully added!');
                      },
                      child: CustomButton(
                        title: 'Post',
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
