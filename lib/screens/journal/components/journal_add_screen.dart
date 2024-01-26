import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minded_hub/components/custom_button.dart';
import 'package:minded_hub/components/custom_snackbar.dart';
import 'package:minded_hub/screens/journal/bloc/journal_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JournalAddScreen extends StatelessWidget {
  const JournalAddScreen({super.key});

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
              BlocProvider.of<JournalBloc>(context).add(JournalLoad());
              Navigator.pop(context, true);
            }),
        title: Text(
          "Add",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocProvider(
        create: (context) => JournalBloc()..add(JournalLoad()),
        child: SingleChildScrollView(
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
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(),
                        ),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Describe your day!',
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
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    BlocProvider.of<JournalBloc>(context).add(JournalAdd(
                        title: title.text, description: description.text));
                    CustomSnackbar()
                        .showCustomSnackBar(context, 'Successfully added!');
                  },
                  child: CustomButton(
                    title: 'Add',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
