import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/auth_provider.dart';
import 'package:flutter_application_2/services/session_manager.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getInit() async {
    Future.delayed(const Duration(seconds: 3), () {
      session.getSession().then((value) async => {
            if (value != "")
              {
                await Provider.of<AuthProvider>(context, listen: false)
                    .loginToken(),
                await Provider.of<ProductProvider>(context, listen: false)
                    .getProducts(),
                Navigator.pushReplacementNamed(context, '/home')
              }
            else
              {Navigator.pushReplacementNamed(context, '/onboarding')}
          });
    });
    // await Provider.of<ProductProvider>(context, listen: false).getProducts();
    // // Navigator.pushNamed(context, '/signin');
    // Timer(
    //     Duration(seconds: 3), () => Navigator.of(context).pushNamed('/signin'));
    // Timer(Duration(seconds: 1), () async {
    //   if (session.getSession().toString() == null) {
    //     Navigator.pushNamed(context, '/signin');
    //   } else {
    //     // context.read<AuthCubit>().getCurrentUser(user.id);
    //     await Provider.of<ProductProvider>(context, listen: false)
    //         .getProducts();
    //     Navigator.pushNamed(context, '/home');
    //   }
    // });
  }

  void initState() {
    getInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      body: Stack(
        children: [
          Center(
              child: Container(
            width: 110,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
              ),
            ),
          )),
          Center(
            child: SpinKitCircle(
                size: 165,
                itemBuilder: (context, index) {
                  final colors = [Colors.grey, Colors.lightBlue, Colors.purple];
                  final color = colors[index % colors.length];

                  return DecoratedBox(
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Power By",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "~APPSKEP~",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
