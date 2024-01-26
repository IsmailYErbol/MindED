import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:minded_hub/screens/community/community_screen.dart';
import 'package:minded_hub/screens/home/home_screen.dart';
import 'package:minded_hub/screens/library/library_screen.dart';
import 'package:minded_hub/screens/profile/profile_screen.dart';
import 'package:minded_hub/screens/sign_in/sign_in_screen.dart';
import 'package:minded_hub/screens/sign_up/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tabbar_event.dart';
part 'tabbar_state.dart';

class TabbarBloc extends Bloc<TabbarEvent, TabbarState> {
  TabbarBloc() : super(TabbarInitial()) {
    int index = 0;
    List screens = [
      HomeScreen(),
      CommunityScreen(),
      LibraryScreen(),
      ProfileScreen()
    ];
    on<TabbarEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = await prefs.getString('id') ?? '';
      if (event is TabbarLoad) {
        // dataa = fetch news smda sd  data null

        if (id == '') {
          screens = [
            HomeScreen(),
            CommunityScreen(),
            LibraryScreen(),
            SignupPage()
          ];
        } else {
          screens = [
            HomeScreen(),
            CommunityScreen(),
            LibraryScreen(),
            ProfileScreen()
          ];
        }

        emit(TabbarLoaded(screens: screens, index: index));
      }
      if (event is TabbarChangePage) {
        print(id);
        if (id == '') {
          screens = [
            HomeScreen(),
            CommunityScreen(),
            LibraryScreen(),
            SignupPage()
          ];
        } else {
          screens = [
            HomeScreen(),
            CommunityScreen(),
            LibraryScreen(),
            ProfileScreen()
          ];
        }
        index = event.index;
        emit(TabbarLoaded(screens: screens, index: index));
      }
      if (event is TabbarLogChangePage) {
        if (event.index == 0) {
          screens = [
            HomeScreen(),
            CommunityScreen(),
            LibraryScreen(),
            SignupPage()
          ];
        } else {
          screens = [
            HomeScreen(),
            CommunityScreen(),
            LibraryScreen(),
            LoginPage()
          ];
        }
        emit(TabbarLoaded(screens: screens, index: index));
      }
    });
  }
}
