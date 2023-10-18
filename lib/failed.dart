import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/dashboard.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/secure_account.dart';
import 'package:h_cash/services/payment_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FailedPage extends StatefulWidget {
  const FailedPage({Key? key}) : super(key: key);
  @override
  State<FailedPage> createState() => _FailedPageState();
}

class _FailedPageState extends State<FailedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
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
                      AppLocalizations.of(context)!.failed,
                      style: TextStyle(
                          color: AppColors.dashboardColor,
                          fontSize: 30,
                          height: 1,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.failed_description,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Center(
                child: Image(
                  image: AssetImage('assets/failed.png'),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: MediaQuery.of(context).size,
                        disabledBackgroundColor: MyTheme.grey_153,
                        //height: 50,
                        backgroundColor: MyTheme.accent_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardPage()));
                      }),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
