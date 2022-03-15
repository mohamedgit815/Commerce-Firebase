import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_functions.dart';
import 'package:commerce/Helper/Constance/const_text.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Helper/Widgets/Defaults/defualt_expandedauth.dart';
import 'package:commerce/Model/user_model.dart';
import 'package:commerce/Update/Functions/auth_functions.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:commerce/Views/View/Cart/main_cart_screen.dart';
import 'package:commerce/Views/View/Favorite/main_favorite_screen.dart';
import 'package:commerce/Views/View/Profile/Setting/main_setting_screen.dart';
import 'package:commerce/Views/View/Profile/SwitchPw/main_changepw_screen.dart';
import 'package:commerce/Views/View/Profile/Update/main_profileupdate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileProfilePage extends StatefulWidget {
  const MobileProfilePage({Key? key}) : super(key: key);

  @override
  _MobileProfilePageState createState() => _MobileProfilePageState();
}

class _MobileProfilePageState extends State<MobileProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: normalWhite,
        centerTitle: true,
        title: CustomText(text: '${translateText(textAccount, context)}',
        fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: lightMainColor,
        ),
      ),
      body: Consumer(
        builder:(context,prov,_)=> prov.watch(_myData).when(
            error: (err,stack)=>errorProvider(err),
            loading: ()=>loadingProvider() ,
          data: (data) {
              final UserModel _data = UserModel.fromApp(data.data()!);

            return Column(
            children:  [
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                       CircleAvatar(
                        radius: 40.0,
                        backgroundColor: _data.image.isEmpty ? lightMainColor : null,
                        backgroundImage:_data.image.isEmpty ? null : NetworkImage(_data.image),
                      ),

                      CustomText(
                        text: '${_data.first} ${_data.last}',
                        fontSize: 17.0,

                      ),

                      AnimatedConditionalBuilder(
                        condition: _data.bio.isNotEmpty,
                        builder: (context)=> CustomText(text: _data.bio.toString()),
                        fallback:(context)=> CustomText(text: _data.email.toString(),
                          color: lightColorThree,
                        ),
                      )
                    ],
                  ),
                ),
              ),


              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: DefaultExpandedAuth(
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: normalWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1.0,
                                    blurRadius: 10.0
                                )
                              ]
                          ),
                          child:  ListTile(
                            title: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(text: '${translateText(textProducts, context)}',)),
                            leading: const Icon(Icons.card_travel_outlined,color: Colors.blue,),
                            trailing: const Icon(Icons.navigate_next_outlined),
                            onTap: (){
                              Navigator.of(context).pushNamed(MainCartScreen.cart);
                            },
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: DefaultExpandedAuth(
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: normalWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1.0,
                                    blurRadius: 10.0
                                )
                              ]
                          ),
                          child:  ListTile(
                            title: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(text: '${translateText(textFavorite, context)}',)),
                            leading: const Icon(Icons.favorite_outline,color: Colors.red,),
                            trailing: const Icon(Icons.navigate_next_outlined),
                            onTap: (){
                              Navigator.of(context).pushNamed(MainFavoriteScreen.favorite);
                            },
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: DefaultExpandedAuth(
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: normalWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1.0,
                                    blurRadius: 10.0
                                )
                              ]
                          ),
                          child:  ListTile(
                            title: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(text: '${translateText(textUpdate, context)}',)),
                            leading: const Icon(Icons.settings,color: Colors.blue,),
                            trailing: const Icon(Icons.navigate_next_outlined),
                            onTap: (){
                              Navigator.of(context).pushNamed(MainProfileUpdateScreen.profileUpdate,arguments: _data);
                            },
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: DefaultExpandedAuth(
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: normalWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1.0,
                                    blurRadius: 10.0
                                )
                              ]
                          ),
                          child:  ListTile(
                            title: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(text: '${translateText(textChange, context)}',)),
                            leading: const Icon(Icons.settings,color: Colors.blue,),
                            trailing: const Icon(Icons.navigate_next_outlined),
                            onTap: (){
                              Navigator.of(context).pushNamed(MainChangePwScreen.changePw);
                            },
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: DefaultExpandedAuth(
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: normalWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1.0,
                                    blurRadius: 10.0
                                )
                              ]
                          ),
                          child:  ListTile(
                            title:  Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(text: '${translateText(textSetting, context)}',)),
                            leading: const Icon(Icons.settings,color: Colors.blue,),
                            trailing: const Icon(Icons.navigate_next_outlined),
                            onTap: () async {
                              Navigator.of(context).pushNamed(MainSettingScreen.setting);
                            },
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: DefaultExpandedAuth(
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: normalWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1.0,
                                    blurRadius: 10.0
                                )
                              ]
                          ),
                          child:  ListTile(
                            title:  Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(text: '${translateText(textLogOut, context)}',)),
                            leading: const Icon(Icons.login,color: Colors.blue,),
                            trailing: const Icon(Icons.navigate_next_outlined),
                            onTap: () async {
                              return await AuthFunctions.signOut(context);
                            },
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          );
          },
        )
      ),
    );
  }
}

final _myData = StreamProvider((ref)=> AuthFunctions.getUserData() );