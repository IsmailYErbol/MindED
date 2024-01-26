import 'package:flutter/material.dart';
import 'package:minded_hub/screens/chat/chat_screen.dart';

class AiBanner extends StatelessWidget {
  const AiBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(
                "https://i.ibb.co.com/GPST3P1/MEET-MINDED-ASISITANT.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned.fill(
          child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 110.0, bottom: 10),
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 48, 67, 82)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) => ChatGPTScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Explore',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_circle_right,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ))
    ]);
  }
}
