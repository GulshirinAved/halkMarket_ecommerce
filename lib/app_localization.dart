import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);
  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  late Map<String, String> _localizedValues;
  Future loadJson() async {
    final String jsonStringValues =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    final Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getTransatedValues(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _ApplocalizationDelegate();
}

class _ApplocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _ApplocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ru', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    final AppLocalization localization = AppLocalization(locale);
    await localization.loadJson();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
