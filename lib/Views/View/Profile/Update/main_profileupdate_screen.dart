import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Views/Main/responsive_builder.dart';
import 'package:commerce/Views/View/Profile/Update/mobile_profileupdate_screen.dart';
import 'package:flutter/material.dart';


class MainProfileUpdateScreen extends StatelessWidget {
  static const String profileUpdate = '/MainProfileUpdateScreen';

  const MainProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = ModalRoute.of(context)!.settings.arguments as UserModel;

    return ResponsiveBuilderScreen(
        mobile: MobileProfileUpdatePage(userModel: userModel)
    );
  }
}
