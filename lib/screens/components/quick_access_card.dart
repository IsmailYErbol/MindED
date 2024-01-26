import 'package:flutter/material.dart';

class QuickAccessCard extends StatelessWidget {
  final String? title;
  final String? image;
  final Color? color;
  const QuickAccessCard(
      {super.key, required this.title, required this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            image.toString(),
            height: 200.0,
            width: 150.0,
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
        Positioned(
          top: 4,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title.toString(),
              style: TextStyle(
                color: (color == null) ? Colors.white : color,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
