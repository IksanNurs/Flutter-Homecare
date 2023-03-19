import 'package:flutter/material.dart';

class SplashOrder extends StatefulWidget {
  const SplashOrder({Key? key}) : super(key: key);

  @override
  State<SplashOrder> createState() => _SplashOrderState();
}

class _SplashOrderState extends State<SplashOrder> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: Image.network(
        "https://assets3.lottiefiles.com/packages/lf20_lxvphqsr.json",
      ))),
    );
  }
}
