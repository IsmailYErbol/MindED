import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/screens/journal/bloc/journal_bloc.dart';
import 'package:minded_hub/screens/journal/components/journal_add_screen.dart';
import 'package:minded_hub/screens/journal/components/journal_card.dart';

class JournalScreen extends StatelessWidget {
  JournalScreen({super.key});

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
          "Journal",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => JournalAddScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state is JournalLoaded) {
            print(state.data);
            return SingleChildScrollView(
              child: (state.data.length == 0)
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1,
                            height: MediaQuery.of(context).size.height / 2,
                            child: Image.network(
                                'https://i.ibb.co.com/TKhsdfq/Untitled-design-7.png'),
                          ),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(
                                  '"Preserve your momeries, keep them well,\n what youforget you can never retell."'),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            ' -Louisa May Alcott',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          children: state.data
                              .map<Widget>((e) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: JournalCard(data: e),
                                  ))
                              .toList()),
                    ),
            );
          }
          return Container(
            child: Text('NOT LOADED'),
          );
        },
      ),
    );
  }
}
