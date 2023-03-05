import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'price_screen.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🤑 Coin Ticker'),
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 10,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage(
                    'images/bitcoin-logo-6219385_960_720.webp',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 20.0, height: 100.0),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 50.0,
                      fontFamily: 'Gajraj One',
                      color: Colors.blueGrey),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('BITCOIN'),
                      RotateAnimatedText('ETHEREUM'),
                      RotateAnimatedText('LITECOIN'),
                    ],
                    onTap: () {
                    },
                    totalRepeatCount: 1000,
                    pause: const Duration(milliseconds: 700),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    side: const BorderSide(
                      color: Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return priceScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'CHECK PRICE',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
