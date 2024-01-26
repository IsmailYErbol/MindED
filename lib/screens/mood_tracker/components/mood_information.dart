import 'package:flutter/material.dart';

class MoodInformationCard extends StatelessWidget {
  final data;
  const MoodInformationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Text(
            data['time'],
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: (data['mood'] == 0)
                        ? Image.network('https://i.ibb.co.com/Bg2c4h4/2.png')
                        : (data['mood'] == 1)
                            ? Image.network(
                                'https://i.ibb.co.com/pJngz1K/1.png')
                            : (data['mood'] == 2)
                                ? Image.network(
                                    'https://i.ibb.co.com/2s67NYD/3.png')
                                : (data['mood'] == 3)
                                    ? Image.network(
                                        'https://i.ibb.co.com/G0yqdJT/4.png')
                                    : Image.network(
                                        'https://i.ibb.co.com/qprBWPp/5.png'),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  (data['mood'] == 0)
                      ? Text('Awful')
                      : (data['mood'] == 1)
                          ? Text('Bad')
                          : (data['mood'] == 2)
                              ? Text('Normal')
                              : (data['mood'] == 3)
                                  ? Text('Good')
                                  : Text('Awesome'),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                data['note'],
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
    );
  }
}
