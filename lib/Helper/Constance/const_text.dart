

import 'package:commerce/Views/Main/app_localizations.dart';
import 'package:flutter/material.dart';

const String textCart = 'textCart';
const String textProfile = 'textProfile';
const String textFavorite = 'textFavorite';
const String textHome = 'textHome';
const String textAccount = 'textAccount';
const String textLogOut = 'textLogOut';
const String textCheckOut = 'textCheckOut';
const String textOther = 'textOther';
const String textMeat = 'textMeat';
const String textVegetables = 'textVegetables';
const String textTotal= 'textTotal';
const String textProducts= 'textProducts';
const String textChange = 'textChange';
const String textUpdate = 'textUpdate';
const String textSetting = 'textSetting';
const String textAddCart = 'textAddCart';
const String textEmptyFav = 'textEmptyFav';
const String textEmptyCart = 'textEmptyCart';
const String textSure = 'textSure';
const String textYes = 'textYes';
const String textNo = 'textNo';

String? translateText(String text,BuildContext context){
  return AppLocalization.of(context)!.translate(text);
}