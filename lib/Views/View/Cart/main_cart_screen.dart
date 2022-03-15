import 'package:commerce/Views/Main/responsive_builder.dart';
import 'package:commerce/Views/View/Cart/mobile_cart_page.dart';
import 'package:flutter/material.dart';


class MainCartScreen extends StatelessWidget {
  static const String cart = '/MainCartScreen';
  const MainCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileCartPage()
    );
  }
}
