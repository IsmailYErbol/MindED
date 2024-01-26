import 'package:flutter/material.dart';
import 'package:minded_hub/screens/functions/functions.dart';

class CommunityPostHeader extends StatelessWidget {
  final String userName;
  final date;
  const CommunityPostHeader(
      {super.key, required this.userName, required this.date});

  @override
  Widget build(BuildContext context) {
    String formattedDate = HelperFunctions().formatTimestamp(date);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 20,
            child: Center(
              child: Text(
                userName.split('')[0].toUpperCase(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                formattedDate,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
