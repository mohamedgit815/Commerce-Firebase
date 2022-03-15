import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_routers.dart';
import 'package:commerce/Helper/Constance/const_validators.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_button.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Helper/Widgets/Defaults/default_authformfield.dart';
import 'package:commerce/Helper/Widgets/Defaults/defualt_expandedauth.dart';
import 'package:commerce/Update/Functions/auth_functions.dart';
import 'package:commerce/Update/State/switch_state.dart';
import 'package:commerce/Views/Auth/Login/main_login_screen.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileForgetPage extends ConsumerStatefulWidget {
  const MobileForgetPage({Key? key}) : super(key: key);

  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends ConsumerState<MobileForgetPage> with _MixinMobileLogin{
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: constGradient
            ),
            child: Form(
              key: _globalKey ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 12) ,

                  DefaultExpandedAuth(
                    child: DefaultAuthFormField(
                      hintText: 'Enter your Email' ,
                      inputType: TextInputType.emailAddress ,
                      inputAction: TextInputAction.next ,
                      validator: (String? v) {
                        return ConstValidators.validatorEmail(v);
                      },

                      controller:  _emailController ,

                    ) ,
                  ) ,

                  const Spacer(flex: 1) ,

                  Column(
                    children: [

                      Consumer(
                        builder:( context , prov , _ ) => AnimatedConditionalBuilder(
                            condition: prov.watch(_loadingProv).varSwitch,
                            builder: (BuildContext context) {
                              return DefaultExpandedAuth(
                                  child: CustomTextButton(
                                    child: CustomText(
                                      text: 'Reset Account' ,
                                      color: constGradient.colors.first ,
                                      fontSize: 17.0 ,
                                      fontWeight: FontWeight.bold ,
                                    ),
                                    onPressed: () async {

                                      FocusScope.of(context).unfocus();

                                      return await AuthFunctions.resetEmailAuth(
                                          email: _emailController.text ,
                                          globalKey: _globalKey ,
                                          route: MainLoginScreen.login ,
                                          context: context ,
                                          state: prov ,
                                          indicatorState: _loadingProv
                                      );
                                    } ,
                                    backGroundColor: normalWhite ,
                                    borderRadius: BorderRadius.circular(25.0) ,
                                  )
                              );
                            },
                            fallback: (BuildContext context){
                              return const Center(child: CircularProgressIndicator.adaptive());
                            }
                        ),
                      ) ,

                      GestureDetector(
                        onTap: () async {
                          return await ConstRouters.backPageRouter(context);
                        },
                        child: const CustomText(
                          text: 'I don\'t Forget my Account?' ,
                          color: normalWhite ,
                        ),
                      ) ,

                    ],
                  ) ,

                  const Spacer(flex: 12)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

mixin _MixinMobileLogin {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final _loadingProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
}