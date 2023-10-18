// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_cash/custom_widgets.dart';
import 'package:h_cash/dashboard.dart';
import 'package:h_cash/input_decorations.dart';
import 'package:h_cash/locale_provider.dart';
import 'package:h_cash/login_page.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';
import 'package:h_cash/my_theme.dart';
import 'package:h_cash/page_widgets.dart';
import 'package:h_cash/services/auth_services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyPreferences extends StatefulWidget {
  const MyPreferences(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  _MyPreferencesState createState() => _MyPreferencesState();
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class _MyPreferencesState extends State<MyPreferences> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _accountController = TextEditingController();
  BuildContext? loadingContext;
  bool biometricsEnabled = false;
  _SupportState _supportState = _SupportState.unknown;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    checkIfBiometrics();
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

  checkIfBiometrics() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      biometricsEnabled = prefs.getBool('biometricsEnabled') ?? false;
    });
  }

  changeBiometrics() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometricsEnabled', biometricsEnabled);
    print(biometricsEnabled);
    if (biometricsEnabled) {
      showToast(context, 'Biometrics enabled successfully!');
    } else {
      showToast(context, 'Biometrics disabled successfully!');
    }
  }

  Widget passwordForm() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Text(
              AppLocalizations.of(context)!.enable_biometrics,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 16,
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
                  child: Switch(
                    value: biometricsEnabled,
                    onChanged: (value) {
                      setState(() {
                        biometricsEnabled = value;
                      });
                      if (_supportState == _SupportState.supported)
                        changeBiometrics();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Text(
              AppLocalizations.of(context)!.main_drawer_change_language,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Row(
              children: [
                PopupMenuButton(
                    icon: const Icon(Icons.language, color: Colors.red),
                    onSelected: (String value) {
                      app_mobile_language.update((p0) => value);
                      setState(() {
                        Provider.of<LocaleProvider>(context, listen: false)
                            .setLocale(app_mobile_language.$);
                      });
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
                Text(
                  app_mobile_language.$ == 'en' ? 'English' : 'Amharic',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ],
      ),
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
                    AppLocalizations.of(context)!.preferences_description),
            passwordForm(),
          ],
        ),
      ),
    );
  }
}
