import 'package:commerce/Views/Auth/Forget/mobile_forget_page.dart';
import 'package:commerce/Views/Main/responsive_builder.dart';
import 'package:flutter/material.dart';


class MainForgetAccountScreen extends StatelessWidget {
  static const String forgetAccount = '/MainForgetAccountScreen';
  const MainForgetAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileForgetPage()
    );
  }
}
