import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/screens/tabbar/bloc/tabbar_bloc.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabbarBloc, TabbarState>(
      builder: (context, state) {
        if (state is TabbarLoaded) {
          return Scaffold(
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
              child: BottomAppBar(
                elevation: 0,
                height: 70,
                color: Colors.green[200],
                shape: const CircularNotchedRectangle(),
                notchMargin: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: (state.screens.length == 5)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TabbarBloc>(context)
                              .add(TabbarChangePage(index: 0));
                        },
                        icon: Icon(Icons.home_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TabbarBloc>(context)
                              .add(TabbarChangePage(index: 1));
                        },
                        icon: Icon(Icons.comment_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TabbarBloc>(context)
                              .add(TabbarChangePage(index: 2));
                        },
                        icon: Icon(Icons.book_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TabbarBloc>(context)
                              .add(TabbarChangePage(index: 3));
                        },
                        icon: Icon(Icons.person_2_outlined),
                      ),
                    ]),
              ),
            ),
            body: state.screens[state.index],
          );
        }
        return Container();
      },
    );
  }
}
