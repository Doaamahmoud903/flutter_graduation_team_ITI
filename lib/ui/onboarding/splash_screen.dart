import 'package:electro_app_team/ui/onboarding/splash_pages.dart';
import 'package:electro_app_team/ui/onboarding/splash_welcome.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "SplashScreen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  bool _startedSplash = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: !_startedSplash
            ? WelcomeScreen(onStart: () {
          setState(() {
            _startedSplash = true;
          });
        })
            :SplashPages()
    );
  }}
