import 'package:commerce/Views/Main/responsive_builder.dart';
import 'package:commerce/Views/View/Favorite/mobile_favorite_page.dart';
import 'package:flutter/material.dart';


class MainFavoriteScreen extends StatelessWidget {
  static const String favorite = '/MainFavoriteScreen';

  const MainFavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileFavoritePage()
    );
  }
}
