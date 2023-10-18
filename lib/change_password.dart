import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/dashboard.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/login_page.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _oldController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _accountController = TextEditingController();
  BuildContext? loadingContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(screenWidth, 60),
            child: CustomAppBar(widget.title, Icons.lock)),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: buildBody(),
        ));
  }

  Widget passwordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.old_pin,
                  style: TextStyle(
                    color: AppColors.greyColor2,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _oldController,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "********", icon: Icons.lock),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.new_pin,
                  style: TextStyle(
                    color: AppColors.greyColor2,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _passwordController,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "********", icon: Icons.lock),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.confirm_new_pin,
                  style: TextStyle(
                    color: AppColors.greyColor2,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _confirmPasswordController,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "*********", icon: Icons.lock),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
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
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        onSubmit();
                      }),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildDescription(widget.title,
                description:
                    AppLocalizations.of(context)!.change_pin_description),
            passwordForm(),
          ],
        ),
      ),
    );
  }

  onSubmit() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    final prefs = await SharedPreferences.getInstance();
    var oldPassword = prefs.getString('user_password');
    var oldPin = _oldController.text.toString();
    var newPin = _passwordController.text.toString();
    var confirmedPin = _confirmPasswordController.text.toString();
    if (oldPin != oldPassword) {
      // ignore: use_build_context_synchronously
      showToast(context, AppLocalizations.of(context)!.old_pin);
      return;
    } else if (newPin.length != 4) {
      // ignore: use_build_context_synchronously
      showToast(context, AppLocalizations.of(context)!.new_pin);
      return;
    } else if (confirmedPin.length != 4) {
      // ignore: use_build_context_synchronously
      showToast(context, AppLocalizations.of(context)!.confirm_new_pin);
      return;
    }
    // loading();
    loading();
    var changePinResponse =
        await AuthService().changePinResponse(user_phone.$, oldPin, newPin);
    Navigator.of(loadingContext!).pop();

    if (changePinResponse.status != 'SUCCESS') {
      // ignore: use_build_context_synchronously
      showToast(context, changePinResponse.message);
    } else {
      // ignore: use_build_context_synchronously
      showToast(context, changePinResponse.message);

      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.clear();
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    }
  }

  loading() {
    showDialog(
        context: context,
        builder: (context) {
          loadingContext = context;
          return AlertDialog(
              content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                width: 10,
              ),
              Text(AppLocalizations.of(context)!.loading_text),
            ],
          ));
        });
  }
}
