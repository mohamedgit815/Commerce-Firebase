import 'package:commerce/Views/Main/responsive_builder.dart';
import 'package:commerce/Views/View/Home/MainHome/mobile_home_page.dart';
import 'package:flutter/material.dart';


class MainHomeScreen extends StatelessWidget {
  static const String home = '/MainHomeScreen';
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileHomePage()
    );
  }
}
