import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    List myLikes = [];
    List myPosts = [];
    String myClass = '';
    String myAge = '';
    String myName = '';
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileLoad) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String id = await prefs.getString('id') ?? '';
        print(id);
        final postRef = FirebaseFirestore.instance.collection('users').doc(id);
        final postData = await postRef.get();

        myLikes = List.from(postData.data()?['myLikes'] ?? []);
        myPosts = List.from(postData.data()?['myPosts'] ?? []);
        print(myPosts);
        myClass = postData.data()?['class'] ?? '';
        myAge = postData.data()?['age'] ?? '';
        myName = postData.data()?['name'] ?? '';
        emit(ProfileLoaded(
            myLikes: myLikes,
            myPosts: myPosts,
            myId: id,
            myName: myName,
            myAge: myAge,
            myClass: myClass));
      }
      if (event is ProfileLogOut) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', '');
        myLikes = [];
        myPosts = [];
        myClass = '';
        myAge = '';
        myName = '';
        String id = '';
        emit(ProfileLoaded(
            myLikes: myLikes,
            myPosts: myPosts,
            myId: id,
            myName: myName,
            myAge: myAge,
            myClass: myClass));
      }
    });
  }
}
