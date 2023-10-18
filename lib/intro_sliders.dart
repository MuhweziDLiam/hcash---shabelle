import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/login_page.dart';
import 'package:h_cash/my_theme.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroSliderDemo extends StatefulWidget {
  const IntroSliderDemo({Key? key}) : super(key: key);

  @override
  State<IntroSliderDemo> createState() => _IntroSliderDemoState();
}

class _IntroSliderDemoState extends State<IntroSliderDemo> {
  List<ContentConfig> slides = [];

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: slides,
      backgroundColorAllTabs: Colors.white,
      onDonePress: onDonePress,
      doneButtonStyle: ButtonStyle(
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w300)),
        backgroundColor: MaterialStateProperty.all(Colors.green),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      nextButtonStyle: ButtonStyle(
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w300)),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      skipButtonStyle: ButtonStyle(
        textStyle:
            MaterialStateProperty.all(TextStyle(fontWeight: FontWeight.w300)),
        backgroundColor: MaterialStateProperty.all(Colors.orange),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  void delaySplash() async {
    await Future.delayed(const Duration(seconds: 5));
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    slides.add(
      ContentConfig(
        widgetTitle: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: const Image(
                    image: AssetImage('assets/logo.png'),
                    height: 30,
                  ),
                ),
              ),
              Text(
                'Send Money',
                style: TextStyle(
                    color: AppColors.dashboardColor,
                    fontSize: 30,
                    height: 1,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        description:
            'Accelerate your finances, seamlessly send money, and empower your financial freedom with our secure and intuitive app',
        pathImage: "assets/intro1.jpg",
        heightImage: 370,
        styleDescription: TextStyle(
            color: MyTheme.font_grey,
            fontSize: 14,
            height: 1.6,
            fontWeight: FontWeight.w300),
        styleTitle: TextStyle(
            color: AppColors.dashboardColor,
            fontSize: 25,
            height: 2,
            fontWeight: FontWeight.w300),
      ),
    );
    slides.add(
      ContentConfig(
        widgetTitle: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: const Image(
                    image: AssetImage('assets/logo.png'),
                    height: 30,
                  ),
                ),
              ),
              Text(
                'Save Money',
                style: TextStyle(
                    color: AppColors.dashboardColor,
                    fontSize: 30,
                    height: 1,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        description:
            'Unlock financial freedom with smart savings. Make every penny count and secure your future.',
        pathImage: "assets/intro2.jpg",
        heightImage: 370,
        styleDescription: TextStyle(
            color: MyTheme.font_grey,
            fontSize: 14,
            height: 1.6,
            fontWeight: FontWeight.w300),
        styleTitle: TextStyle(
            color: AppColors.dashboardColor,
            fontSize: 25,
            height: 2,
            fontWeight: FontWeight.w300),
      ),
    );
    slides.add(
      ContentConfig(
        widgetTitle: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: const Image(
                    image: AssetImage('assets/logo.png'),
                    height: 30,
                  ),
                ),
              ),
              Text(
                'Easy To Use',
                style: TextStyle(
                    color: AppColors.dashboardColor,
                    fontSize: 30,
                    height: 1,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        description:
            'Scan, pay, and experience the convenience of effortless transactions at your fingertips.',
        pathImage: "assets/intro3.jpg",
        heightImage: 370,
        styleDescription: TextStyle(
            color: MyTheme.font_grey,
            fontSize: 14,
            height: 1.6,
            fontWeight: FontWeight.w300),
        styleTitle: TextStyle(
            color: AppColors.dashboardColor,
            fontSize: 25,
            height: 2,
            fontWeight: FontWeight.w300),
      ),
    );
    // delaySplash();
    FlutterNativeSplash.remove();
  }
}
