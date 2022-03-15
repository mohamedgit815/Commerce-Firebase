import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangState extends ChangeNotifier {
  final String _key = "lang";
  SharedPreferences? _prefs;
  late bool _lang;

  bool get lang => _lang;

  LangState() {
    _lang = true;
    _loadFromPrefs();
  }

  toggleLang() {
    _lang = !_lang;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _lang = _prefs!.getBool(_key) ?? true;
    notifyListeners();
  }


  _saveToPrefs() async {
    await _initPrefs();
    await _prefs!.setBool(_key, _lang);
  }
}