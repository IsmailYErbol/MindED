import 'package:flutter/material.dart';
import 'package:minded_hub/components/custom_button.dart';
import 'package:minded_hub/screens/onboarding/components/onboard_model.dart';
import 'package:minded_hub/screens/tabbar/tabbar_screen.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(contents[0].image!),
            fit: BoxFit.cover, // Make the image cover the entire container
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      Text(
                        contents[i].title!,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          contents[0].discription!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TabBarScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: CustomButton(title: 'Start Your Discovery'),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),

            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: List.generate(
            //       contents.length,
            //       (index) => buildDot(index, context),
            //     ),
            //   ),
            // ),
            // Container(
            //   height: 60,
            //   margin: EdgeInsets.all(40),
            //   width: double.infinity,
            //   child: TextButton(
            //     child: Text(
            //       currentIndex == contents.length - 1
            //           ? "Start Your Discovery"
            //           : "Next",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //     onPressed: () {
            //       if (currentIndex == contents.length - 1) {

            //       }
            //       _controller.nextPage(
            //         duration: Duration(milliseconds: 100),
            //         curve: Curves.bounceIn,
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
    );
  }
}
