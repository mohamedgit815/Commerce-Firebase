import 'package:commerce/Views/Main/responsive_builder.dart';
import 'package:commerce/Views/View/Profile/SwitchPw/mobile_changepw_page.dart';
import 'package:flutter/material.dart';

class MainChangePwScreen extends StatelessWidget {
  static const String changePw = '/MainChangePwScreen';
  const MainChangePwScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
      mobile: MobileChangePwPage(),
    );
  }
}
