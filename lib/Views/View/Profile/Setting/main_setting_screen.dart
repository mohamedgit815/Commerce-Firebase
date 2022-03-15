import 'package:commerce/Views/Main/responsive_builder.dart';
import 'package:commerce/Views/View/Profile/Setting/mobile_setting_page.dart';
import 'package:flutter/material.dart';

class MainSettingScreen extends StatelessWidget {
  static const String setting = '/MainSettingScreen';
  const MainSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileSettingPage()
    );
  }
}
