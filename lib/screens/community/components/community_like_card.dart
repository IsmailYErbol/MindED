import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/screens/community/components/ocmmunity_comments_bottomsheet_screen.dart';
import 'package:minded_hub/screens/profile/bloc/profile_bloc.dart';

class CommunityLikeScreen extends StatelessWidget {
  final bool isLiked;
  final String likeCount;
  final String commentId;
  final String commentCount;
  final commentData;
  const CommunityLikeScreen(
      {super.key,
      required this.commentId,
      required this.commentData,
      required this.isLiked,
      required this.likeCount,
      required this.commentCount});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    (isLiked == false)
                        ? InkWell(
                            onTap: () async {
                              final postRef = FirebaseFirestore.instance
                                  .collection('post')
                                  .doc(commentId);
                              final postData = await postRef.get();

                              if (postData.exists) {
                                final likesList =
                                    List.from(postData.data()?['likes'] ?? []);

                                if (likesList.contains(state.myId)) {
                                  likesList.remove(state
                                      .myId); // User already liked, so remove their ID
                                } else {
                                  likesList.add(state
                                      .myId); // User didn't like, so add their ID
                                }

                                await postRef.update({'likes': likesList});
                              }
                            },
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              size: 20,
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              final postRef = FirebaseFirestore.instance
                                  .collection('post')
                                  .doc(commentId);
                              final postData = await postRef.get();

                              if (postData.exists) {
                                final likesList =
                                    List.from(postData.data()?['likes'] ?? []);

                                if (likesList.contains(state.myId)) {
                                  likesList.remove(state
                                      .myId); // User already liked, so remove their ID
                                } else {
                                  likesList.add(state
                                      .myId); // User didn't like, so add their ID
                                }
                                await postRef.update({'likes': likesList});
                              }
                            },
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(likeCount)
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter state) {
                              return CommentsBottomSheet(
                                state: state,
                                data: commentData,
                                commentId: commentId,
                              );
                            });
                          },
                        );
                      },
                      child: Icon(
                        Icons.comment_outlined,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(commentCount)
                  ],
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
