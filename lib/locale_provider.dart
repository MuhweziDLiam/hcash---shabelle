import 'package:flutter/material.dart';
import 'package:h_cash/marketplace/shared_value_helper.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale get locale {
    return _locale =
        Locale(app_mobile_language.$ == '' ? "en" : app_mobile_language.$, '');
  }

  void setLocale(String code) {
    _locale = Locale(code, '');
    notifyListeners();
  }
}
