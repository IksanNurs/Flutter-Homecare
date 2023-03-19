import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/pages/forgot_password.dart';
import 'package:flutter_application_2/pages/home/onboarding_page.dart';
import 'package:flutter_application_2/pages/reset_password.dart';
import 'package:flutter_application_2/providers/district_provider.dart';
import 'package:flutter_application_2/providers/edituser_provider.dart';
import 'package:flutter_application_2/providers/province_provider.dart';
import 'package:flutter_application_2/providers/subdistrict_provider.dart';
import 'package:flutter_application_2/providers/village_provider.dart';
import 'package:provider/provider.dart';
import '../pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/checkout_success.dart';
// import '../pages/detail_chat.dart';
import '../pages/edit_profile.dart';
import '../pages/home/main_page.dart';
import '../pages/sign_in.dart';
import '../pages/sign_up.dart';
import '../pages/splash_screen.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/page_provider.dart';
import '../providers/product_provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await Firebase.initializeApp();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ProvinceProvider()),
        ChangeNotifierProvider(create: (context) => DistrictProvider()),
        ChangeNotifierProvider(create: (context) => SubdistrictProvider()),
        ChangeNotifierProvider(create: (context) => EditUserProvider()),
        ChangeNotifierProvider(create: (context) => VillagesProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => PageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          '/onboarding': (context) => const OnBoardingPage(),
          '/signin': (context) => SignIn(),
          '/signup': (context) => SignUp(),
          '/forgot': (context) => ForgotPassword(),
          '/reset': (context) => ResetPassword(),
          '/home': (context) => MainPage(),
          // '/detail-chat': (context) => DetailChatPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccess(),
        },

        // home: SplashScreen(),
      ),
    );
  }
}
