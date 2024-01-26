import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/const/constants.dart';
import 'package:minded_hub/screens/profile/bloc/profile_bloc.dart';
import 'package:minded_hub/screens/community/components/community_like_card.dart';
import 'package:minded_hub/screens/community/components/community_post.dart';
import 'package:minded_hub/screens/community/components/community_post_body.dart';
import 'package:minded_hub/screens/community/components/community_post_user_header.dart';
import 'package:minded_hub/screens/tabbar/bloc/tabbar_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<ProfileBloc>(context).add(ProfileLogOut());
                BlocProvider.of<TabbarBloc>(context)
                    .add(TabbarChangePage(index: 3));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.login,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocProvider(
          create: (context) => ProfileBloc()..add(ProfileLoad()),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(primaryPadding),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 30,
                                child: Center(
                                  child: Text(
                                      state.myName.split('')[0].toUpperCase()),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              state.myName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Age: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              width: 4,
                            ),
                            Text(state.myAge + ' y.o ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('Class: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(state.myClass + 'th grade ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Posts ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        (state.myPosts.length > 0)
                            ? StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('post')
                                    .where(FieldPath.documentId,
                                        whereIn: state.myPosts)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // Show loading indicator while fetching data
                                  }

                                  final posts = snapshot.data!.docs;

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: posts.length,
                                    itemBuilder: (context, index) {
                                      final post = posts[index];
                                      final data =
                                          post.data() as Map<String, dynamic>;

                                      // Display your post data here
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
                                              description:
                                                  data['postDescription'],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CommunityLikeScreen(
                                              commentId: data['id'],
                                              commentData: data['comments'],
                                              isLiked: data['likes']
                                                      .contains(state.myId)
                                                  ? true
                                                  : false,
                                              likeCount: data['likes']
                                                  .length
                                                  .toString(),
                                              commentCount: data['comments']
                                                  .length
                                                  .toString(),
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
                                },
                              )
                            : Text('No posts yet!')
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ));
  }
}
