import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/pages/create_pin.dart';
import 'package:smart_pay/pages/home.dart';
import 'package:smart_pay/pages/id.dart';
import 'package:smart_pay/pages/onboarding_one.dart';
import 'package:smart_pay/pages/otp_authentication.dart';
import 'package:smart_pay/pages/pinLogin.dart';
import 'package:smart_pay/pages/sign_in.dart';
import 'package:smart_pay/pages/sign_up.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(
    Duration(seconds: 5),
  );
  FlutterNativeSplash.remove();
  final prefs = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  final isLoggedIn = prefs.containsKey('token');
  final pin = await secureStorage.read(key: 'pin');

  // To load the .env file contents into dotenv
  await dotenv.load(fileName: ".env");
  runApp(MyApp(isLoggedIn: isLoggedIn, hasPin: pin != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool hasPin;

  const MyApp({super.key, required this.isLoggedIn, required this.hasPin});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Pay',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn && hasPin ? PinLoginScreen() : const OnboardingOne(),
      routes: {
        '/home': (context) => Home(),
        '/sign_in': (context) => Sign_In(),
        '/sign_up': (context) => const Sign_Up(),
        '/otp': (context) => const OTP_Authentication(),
        '/id': (context) => const ID(),
        '/create_pin': (context) => const Create_Pin()
      },
    );
  }
}
