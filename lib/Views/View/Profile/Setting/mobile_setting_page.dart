import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_state.dart';
import 'package:commerce/Helper/Constance/const_text.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileSettingPage extends StatefulWidget {
  const MobileSettingPage({Key? key}) : super(key: key);

  @override
  _MobileSettingPageState createState() => _MobileSettingPageState();
}

class _MobileSettingPageState extends State<MobileSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: lightMainColor,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            backgroundColor: normalWhite,
            centerTitle: true,
            title: CustomText(text: '${translateText(textSetting, context)}',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: lightMainColor,
            ),
          ),
        body: Column(
          children: [
            Consumer(
                builder:(context,prov,_)=> SwitchListTile.adaptive(
                  title: CustomText(
                    alignment: Alignment.centerLeft,
                    text: !prov.watch(langProv).lang ? 'Arabic' : 'English',),
                value: prov.read(langProv).lang, onChanged: (v) {
                  prov.read(langProv).toggleLang();
            })
            )
          ],
        ),
      ),
    );
  }
}
