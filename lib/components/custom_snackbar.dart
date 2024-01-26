import 'package:flutter/material.dart';

class CustomSnackbar {
  void showCustomSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green, // Customize color here
      behavior: SnackBarBehavior.floating, // Use 'fixed' or 'floating'
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)), // Customize shape here
      margin: EdgeInsets.all(10), // Use this to add margin (if floating)
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: 10), // Customize padding here
      duration: Duration(seconds: 3), // Customize duration here
      action: SnackBarAction(
        label: 'Cencel', // Customize action label here
        onPressed: () {
          // Action when user presses 'Undo'
        },
        textColor: Colors.white, // Customize action text color here
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
