import 'package:flutter/material.dart';

class LangConfig {
  static const langList = [
    'am',
    'en',
  ];
  List<Locale> localList = [];

  List<Locale> supportedLocales() {
    langList.forEach((lang) {
      var local = Locale(lang, '');
      localList.add(local);
    });

    return localList;
  }
}
