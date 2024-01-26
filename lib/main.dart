// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/firebase_options.dart';
import 'package:minded_hub/screens/home/home_screen.dart';
import 'package:minded_hub/screens/journal/bloc/journal_bloc.dart';
import 'package:minded_hub/screens/mood_tracker/bloc/mood_tracker_bloc.dart';
import 'package:minded_hub/screens/onboarding/onboarding_screen.dart';
import 'package:minded_hub/screens/profile/bloc/profile_bloc.dart';
import 'package:minded_hub/screens/tabbar/bloc/tabbar_bloc.dart';
import 'package:minded_hub/screens/tabbar/tabbar_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Ensure this screen is created for user login
// Other imports...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.setString('id', '');

  runApp(MindEdHubApp());
}

class MindEdHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabbarBloc()..add(TabbarLoad()),
        ),
        BlocProvider(
          create: (context) => JournalBloc()..add(JournalLoad()),
        ),
        BlocProvider(
          create: (context) => MoodTrackerBloc()..add(MoodTrackerLoad()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc()..add(ProfileLoad()),
        ),
      ],
      child: MaterialApp(
        title: 'MindEd Hub',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Onbording(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
