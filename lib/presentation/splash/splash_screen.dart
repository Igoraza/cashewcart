import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_sample/core/constants.dart';
import 'package:internship_sample/presentation/main_page/main_page_screen.dart';
import 'package:internship_sample/presentation/onboarding/onboarding_screen.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    gotoOnboardScreenAfterDelay(2);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Image(
                image: AssetImage("lib/core/assets/images/logos/app_logo.png"),
                width: screenSize.width * 0.8,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoOnboardScreenAfterDelay(int delayInSeconds) async {
    await Future.delayed(Duration(seconds: delayInSeconds));
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final email = sharedPref.getString(EMAIL);
    final encryptedPassword = sharedPref.getString(ENCRYPTEDPASSWORD);

    if (email != null && encryptedPassword != null) {
      print("have email and password");
      Get.offAll(() => MainPageScreen());
    } else {
      print("dont have email and password");
      Get.offAll(() => OnboardingScreen());
    }
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => OnboardingScreen(),
    //   ),
    // );
  }
}
