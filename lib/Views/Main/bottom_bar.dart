import 'package:commerce/Helper/Constance/const_text.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Update/State/bottombar_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainBottomBarScreen extends ConsumerWidget {
  static const String bottomBar = '/MainBottomBarScreen';
  const MainBottomBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final DateTime _dateTime = DateTime.now();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: WillPopScope(
        onWillPop: () async {
          return customExitApp(dateTime: _dateTime);
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: const Icon(Icons.home_outlined),label: '${translateText(textHome, context)}') ,
              BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart_outlined),label: '${translateText(textCart, context)}') ,
              BottomNavigationBarItem(icon: const Icon(Icons.favorite_border_outlined),label: '${translateText(textFavorite, context)}') ,
              BottomNavigationBarItem(icon: const Icon(CupertinoIcons.profile_circled),label: '${translateText(textProfile, context)}') ,
            ],
            currentIndex: ref.read(_bottomBar).count,
            onTap: (int v){
              ref.read(_bottomBar).countState(v);
            },
          ),
          body: Stack(
                children: ref.read(_bottomBar).pages.asMap()
                    .map((i, screen) => MapEntry(i,
                    Offstage(offstage: ref.watch(_bottomBar).count != i,child: screen,)))
                    .values.toList()

            ),
        ),
      ),
    );
  }
}

final  _bottomBar = ChangeNotifierProvider<BottomBarState>((ref)=>BottomBarState());