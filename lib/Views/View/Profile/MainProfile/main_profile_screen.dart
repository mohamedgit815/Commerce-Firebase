import 'package:commerce/Views/Main/responsive_builder.dart';
import 'package:commerce/Views/View/Profile/MainProfile/mobile_profile_page.dart';
import 'package:flutter/material.dart';

class MainProfileScreen extends StatelessWidget {
  static const String profile = '/MainProfileScreen';

  const MainProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileProfilePage()
    );
  }
}
