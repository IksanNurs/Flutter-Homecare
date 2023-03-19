import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/edit_profile.dart';
import 'package:flutter_application_2/services/session_manager.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text("Main Page")),
//       ),
//     );
//   }
// }
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../pages/home/chat_page.dart';
import '../../pages/home/home_page.dart';
import '../../pages/home/profile_page.dart';
import '../../pages/home/wishlist_page.dart';
import '../../providers/auth_provider.dart';
import '../../providers/page_provider.dart';
import '../../theme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageProvider pageProvider = PageProvider();

  @override
  Widget build(BuildContext context) {
    pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel userModel = authProvider.userModel;

    Widget _cartButton() {
      return Align(
        alignment: Alignment(0, 0.84),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          child: Image.asset('assets/icon_cart.png', width: 20, height: 20),
          backgroundColor: secondaryColor,
        ),
      );
    }

    Widget _customButtonNavbar() {
      return CurvedNavigationBar(
          buttonBackgroundColor: secondaryColor,
          backgroundColor: Colors.transparent,
          color: bgColor1,
          animationDuration: Duration(milliseconds: 300),
          height: 70,
          index: pageProvider.currentIndex,
          onTap: (value) {
            print(value);
            setState(() {
              pageProvider.currentIndex = value;
            });
          },
          items: [
            Image.asset(
              'assets/icon_home.png',
              width: 19,
              color: pageProvider.currentIndex == 0
                  ? Colors.white
                  : Color(0xff808191),
            ),
            Image.asset(
              'assets/icon_chat.png',
              width: 20,
              color: pageProvider.currentIndex == 1
                  ? Colors.white
                  : Color(0xff808191),
            ),
            Image.asset(
              'assets/icon_wishlist.png',
              width: 20,
              color: pageProvider.currentIndex == 2
                  ? Colors.white
                  : Color(0xff808191),
            ),
            Image.asset(
              'assets/icon_profile.png',
              width: 18,
              color: pageProvider.currentIndex == 3
                  ? Colors.white
                  : Color(0xff808191),
            ),
          ]);
    }

    cekUpdateSession() async {
      if (await session.getSession() != userModel.token.toString()) {
        await session.clearSession();
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/signin', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Token expired, Silahkan login Kembali',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    cekUpdateSession();
    Widget _body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const ChatPage();
        case 2:
          return const WishlistPage();
        case 3:
          return const ProfilePage();
        default:
          return const HomePage();
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 53, 15, 114),
      // floatingActionButton: _cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _customButtonNavbar(),
      body: Center(
        child: (userModel.district?.id == null)
            ? const EditProfilePage()
            : _body(),
      ),
    );
  }
}
