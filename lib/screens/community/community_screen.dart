import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/components/custom_snackbar.dart';
import 'package:minded_hub/const/constants.dart';
import 'package:minded_hub/screens/community/components/community_like_card.dart';
import 'package:minded_hub/screens/community/components/community_post.dart';
import 'package:minded_hub/screens/community/components/community_post_body.dart';
import 'package:minded_hub/screens/community/components/community_post_user_header.dart';
import 'package:minded_hub/screens/profile/bloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Community",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            InkWell(onTap: () {}, child: Icon(Icons.message_outlined)),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String id = await prefs.getString('id') ?? '';
                if (id == '') {
                  CustomSnackbar()
                      .showCustomSnackBar(context, 'You have not log in!');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (_) => CommunityPostScreen(),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Post'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.add_box_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(primaryPadding),
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('post')
                            .orderBy('date', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {}
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                DocumentSnapshot data =
                                    snapshot.data!.docs[index];
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommunityPostHeader(
                                          userName: data['userName'],
                                          date: data['date']),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CommunityPostBodyCard(
                                        title: data['postTitle'],
                                        description: data['postDescription'],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CommunityLikeScreen(
                                        commentId: data['id'],
                                        commentData: data['comments'],
                                        isLiked:
                                            data['likes'].contains(state.myId)
                                                ? true
                                                : false,
                                        likeCount:
                                            data['likes'].length.toString(),
                                        commentCount:
                                            data['comments'].length.toString(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        thickness: 1.5,
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(child: Text("No books"));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ));
  }
}
