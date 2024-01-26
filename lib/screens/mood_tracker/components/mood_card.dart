import 'package:flutter/material.dart';

class MoodCard extends StatelessWidget {
  final String iconUrl;
  final String text;
  final bool isSelected;
  const MoodCard(
      {super.key,
      required this.iconUrl,
      required this.text,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (isSelected == false) ? Colors.grey[200] : Colors.white,
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(height: 40, width: 40, child: Image.network(iconUrl)),
          SizedBox(
            height: 2,
          ),
          Text(text)
        ],
      ),
    );
  }
}
