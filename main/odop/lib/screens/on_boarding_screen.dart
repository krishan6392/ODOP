import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odop/screens/main_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const String id = 'onboard-screen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  onButtonPressed(context) {
    return Navigator.pushReplacementNamed(context, MainScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (val) {},
            children: [
              OnBoardPage(
                boardColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'WELCOME TO ODOP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    const Text(
                      '+10 Billion Products\n +100 Categories\n +20 Brands',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.asset('assets/images/cart.png'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  child: const Text(
                    'START SHOPPING',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    onButtonPressed(context);
                  },
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardPage extends StatelessWidget {
  final Column? boardColumn;
  const OnBoardPage({Key? key, this.boardColumn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(child: boardColumn),
    );
  }
}
