import 'package:commerce/Views/Auth/Forget/main_forget_screen.dart';
import 'package:commerce/Views/Auth/Login/main_login_screen.dart';
import 'package:commerce/Views/Auth/SignUp/main_signup_screen.dart';
import 'package:commerce/Views/Main/bottom_bar.dart';
import 'package:commerce/Views/View/Cart/main_cart_screen.dart';
import 'package:commerce/Views/View/Favorite/main_favorite_screen.dart';
import 'package:commerce/Views/View/Home/DetailsHome/main_details_home_screen.dart';
import 'package:commerce/Views/View/Profile/Setting/main_setting_screen.dart';
import 'package:commerce/Views/View/Profile/SwitchPw/main_changepw_screen.dart';
import 'package:commerce/Views/View/Profile/Update/main_profileupdate_screen.dart';
import 'package:flutter/material.dart';



class RouteBuilder {
  static Map<String,WidgetBuilder> routes = {
    MainBottomBarScreen.bottomBar : (BuildContext context)=> const MainBottomBarScreen() ,
    MainLoginScreen.login : (BuildContext context)=> const MainLoginScreen() ,
    MainSignUpScreen.signUP : (BuildContext context)=> const MainSignUpScreen() ,
    MainDetailsHomeScreen.detailsHome : (BuildContext context)=> const MainDetailsHomeScreen() ,
    MainForgetAccountScreen.forgetAccount : (BuildContext context)=> const MainForgetAccountScreen(),
    MainCartScreen.cart : (BuildContext context)=> const MainCartScreen(),
    MainFavoriteScreen.favorite : (BuildContext context)=> const MainFavoriteScreen(),
    MainChangePwScreen.changePw : (BuildContext context)=> const MainChangePwScreen(),
    MainSettingScreen.setting : (BuildContext context)=> const MainSettingScreen(),
    MainProfileUpdateScreen.profileUpdate : (BuildContext context)=> const MainProfileUpdateScreen(),
  };
}