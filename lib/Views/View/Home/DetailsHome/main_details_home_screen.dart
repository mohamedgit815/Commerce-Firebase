import 'package:commerce/Model/cart_model.dart';
import 'package:commerce/Views/Main/responsive_builder.dart';
import 'package:commerce/Views/View/Home/DetailsHome/mobile_details_home_page.dart';
import 'package:flutter/material.dart';


class MainDetailsHomeScreen extends StatelessWidget {
  static const String detailsHome = '/MainDetailsHomeScreen';
  const MainDetailsHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartModel cartModel = ModalRoute.of(context)!.settings.arguments as CartModel;

    return ResponsiveBuilderScreen(
        mobile: MobileDetailsHomePage(cartModel: cartModel)
    );
  }
}
