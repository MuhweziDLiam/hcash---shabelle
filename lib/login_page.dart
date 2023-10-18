// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:h_cash/app_colors.dart';
import 'package:h_cash/auth_helper.dart';
import 'package:h_cash/auth_repository.dart';
import 'package:h_cash/dashboard.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/locale_provider.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/marketplace/toast_component.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/register.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  BuildContext? loadingContext;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool biometricsEnabled = false;

  @override
  void initState() {
    super.initState();
    // checkIfBiometrics();
    print(app_mobile_language.$);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text(
                      'Language',
                      style: TextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: PopupMenuButton(
                        icon: const Icon(Icons.language, color: Colors.red),
                        onSelected: (String value) {
                          app_mobile_language.update((p0) => value);
                          Provider.of<LocaleProvider>(context, listen: false)
                              .setLocale(app_mobile_language.$);
                        },
                        itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              PopupMenuItem(
                                value: 'am',
                                child: Text('Amharic'),
                              ),
                            ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(5),
                    //     child: const Image(
                    //       image: AssetImage('assets/logo.png'),
                    //       height: 30,
                    //     ),
                    //   ),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.main_drawer_login,
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
                  AppLocalizations.of(context)!.login_description,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Image(
                  image: AssetImage('assets/login.jpg'),
                  height: 250,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.order_details_screen_phone,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
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
                        controller: phoneController,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "0700460055", icon: Icons.phone),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.login_screen_password,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 36,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: pinController,
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "********", icon: Icons.pin),
                      ),
                    ),
                  ],
                ),
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
                      child: Text(
                        AppLocalizations.of(context)!.main_drawer_login,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        onSubmit();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const DashboardPage()));
                      }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  AppLocalizations.of(context)!
                      .login_screen_or_create_new_account,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: MediaQuery.of(context).size,
                        disabledBackgroundColor: MyTheme.grey_153,
                        //height: 50,
                        backgroundColor: MyTheme.font_grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        // onSubmit();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      }),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Please complete verification to login to the application',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message =
        authenticated ? 'Login successful' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
    showToast(context, _authorized);
    if (authenticated) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DashboardPage();
      }));
    }
  }

  checkIfBiometrics() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      biometricsEnabled = prefs.getBool('biometricsEnabled') ?? false;
    });
    if (biometricsEnabled) _authenticateWithBiometrics();
  }

  onSubmit() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    var phone = phoneController.text.toString();
    var pin = pinController.text.toString();
    if (phone == "") {
      showToast(
          context, AppLocalizations.of(context)!.login_screen_phone_warning);
      return;
    } else if (pin == "") {
      showToast(
          context, AppLocalizations.of(context)!.login_screen_password_warning);
      return;
    }
    loading();

    var loginResponse = await AuthRepository().getLoginResponse(phone, pin);
    Navigator.of(loadingContext!).pop();
    if (loginResponse.status != 'SUCCESS') {
      showToast(context, loginResponse.message);
      return;
    } else {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('user_password', pin);
      // ToastComponent.showDialog(loginResponse.message,
      //     gravity: Toast.center, duration: Toast.lengthLong);
      AuthHelper().setUserData(loginResponse);
      showToast(context, loginResponse.message);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DashboardPage();
      }));
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
              CircularProgressIndicator(color: MyTheme.accent_color),
              const SizedBox(
                width: 10,
              ),
              Text(AppLocalizations.of(context)!.loading_text),
            ],
          ));
        });
  }
}
