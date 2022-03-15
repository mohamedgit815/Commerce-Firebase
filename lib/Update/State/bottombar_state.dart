import 'package:commerce/Views/View/Cart/main_cart_screen.dart';
import 'package:commerce/Views/View/Favorite/main_favorite_screen.dart';
import '../../Views/View/Profile/MainProfile/main_profile_screen.dart';
import 'package:flutter/material.dart';
import '../../Views/View/Home/MainHome/main_home_screen.dart';

class BottomBarState extends ChangeNotifier {
  int count = 0;

  final List<Widget> pages = const [
    MainHomeScreen() ,
    MainCartScreen() ,
    MainFavoriteScreen(),
    MainProfileScreen(),
  ];

  int countState(int v) {
    notifyListeners();
    return count = v;
  }
}