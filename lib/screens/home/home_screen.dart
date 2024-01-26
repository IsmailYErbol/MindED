import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/const/constants.dart';
import 'package:minded_hub/screens/community/community_screen.dart';
import 'package:minded_hub/screens/components/quick_access_card.dart';
import 'package:minded_hub/screens/home/components/ai_banner.dart';
import 'package:minded_hub/screens/journal/journal_screen.dart';
import 'package:minded_hub/screens/mood_tracker/mood_tracker_screen.dart';
import 'package:minded_hub/screens/tabbar/bloc/tabbar_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(primaryPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to MidEd!',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              ),
              SizedBox(
                height: 30,
              ),
              AiBanner(),
              SizedBox(
                height: 30,
              ),
              Text(
                'Tools',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => CommunityScreen(),
                        ),
                      );
                    },
                    child: QuickAccessCard(
                      image:
                          'https://i.ibb.co.com/7SGZThH/Untitled-design-2.png',
                      title: 'Community',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => MoodTrackerScreen(),
                        ),
                      );
                    },
                    child: QuickAccessCard(
                      image:
                          'https://i.ibb.co.com/d5mGxzf/Untitled-design-3.png',
                      title: 'Mood Tracker',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<TabbarBloc>(context)
                          .add(TabbarChangePage(index: 2));
                    },
                    child: QuickAccessCard(
                      image:
                          'https://i.ibb.co.com/4NbBp6v/Untitled-design-4.png',
                      title: 'Library',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => JournalScreen(),
                        ),
                      );
                    },
                    child: QuickAccessCard(
                      image:
                          'https://i.ibb.co.com/488fpc1/Untitled-design-5.png',
                      title: 'Journal',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
