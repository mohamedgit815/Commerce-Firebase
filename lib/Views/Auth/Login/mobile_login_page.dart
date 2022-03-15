import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_firebase.dart';
import 'package:commerce/Helper/Constance/const_routers.dart';
import 'package:commerce/Helper/Constance/const_validators.dart';
import 'package:commerce/Helper/Constance/const_widgets.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_button.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Helper/Widgets/Defaults/default_authformfield.dart';
import 'package:commerce/Helper/Widgets/Defaults/defualt_expandedauth.dart';
import 'package:commerce/Update/Functions/auth_functions.dart';
import 'package:commerce/Update/State/switch_state.dart';
import 'package:commerce/Views/Auth/Forget/main_forget_screen.dart';
import 'package:commerce/Views/Auth/SignUp/main_signup_screen.dart';
import 'package:commerce/Views/Main/bottom_bar.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class MobileLoginPage extends ConsumerStatefulWidget {
  const MobileLoginPage({Key? key}) : super(key: key);

  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends ConsumerState<MobileLoginPage> with _MixinMobileLogin{
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
                    const Spacer(flex: 12,),


                    Column(
                      children: [
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

                        const SizedBox(height: 10.0) ,

                        DefaultExpandedAuth(
                          child: Consumer(
                            builder:( context , prov , _ )=> DefaultAuthFormField(
                              hintText: 'Enter your Password' ,
                              inputType: TextInputType.visiblePassword ,
                              inputAction: TextInputAction.done ,
                              password: prov.watch(_checkPwProv).varSwitch ,
                                suffixIcon: AnimatedConditionalBuilder(
                                  duration: const Duration(milliseconds: 200),
                                  condition: !prov.read(_checkPwProv).varSwitch,
                                  builder: (BuildContext context) {
                                    return ConstWidgets.iconButtonVisibility(ref: prov,icon: Icons.visibility_off,state: _checkPwProv);
                                  },
                                  fallback: (BuildContext context){
                                    return ConstWidgets.iconButtonVisibility(ref: prov,icon: Icons.visibility,state: _checkPwProv);
                                  },
                                )

                              ,
                              validator: (String? v) {
                                return v!.isEmpty ? 'Enter your Password by right Form': null;
                                },

                              controller:  _pwController ,
                              onSubmitted: (v) async {
                                FocusScope.of(context).unfocus();

                                return await AuthFunctions.loginAuth(
                                    email: _emailController.text ,
                                    password: _pwController.text ,
                                    globalKey: _globalKey ,
                                    route: MainBottomBarScreen.bottomBar ,
                                    context: context ,
                                    state: ref ,
                                    indicatorState: _loadingProv
                                );
                              },
                            ),
                          ),
                        ) ,
                      ],
                    ) ,


                    const Spacer(flex: 1,),


                    Column(
                      children: [

                        GestureDetector(
                          onTap: () async {
                            return await ConstRouters.pushNamedRouter(
                                route: MainForgetAccountScreen.forgetAccount, context: context);
                          },
                          child: const CustomText(
                            text: 'Forget your Password ?' ,
                            color: normalWhite ,
                          ),
                        ) ,

                        Builder(
                          builder: (context) {
                            return Consumer(
                              builder:( context , prov , _ ) => AnimatedConditionalBuilder(
                                  condition: prov.watch(_loadingProv).varSwitch,
                                  builder: (BuildContext context) {
                                    return DefaultExpandedAuth(
                                        child: CustomTextButton(
                                          child: CustomText(
                                            text: 'Login' ,
                                            color: constGradient.colors.first ,
                                            fontSize: 17.0 ,
                                            fontWeight: FontWeight.bold ,
                                          ),
                                          onPressed: () async {
                                            try {
                                              FocusScope.of(context).unfocus();
                                              _globalKey.currentState!.save();
                                              if (_globalKey.currentState!.validate()) {
                                                prov.read(_loadingProv).falseSwitch();
                                                await firebaseAuth.signInWithEmailAndPassword(
                                                    email: _emailController.text, password: _pwController.text);

                                                  await AuthFunctions.updateToken();

                                                await Navigator.of(context).pushNamedAndRemoveUntil(
                                                    MainBottomBarScreen.bottomBar, (route) => false);

                                                prov.read(_loadingProv).trueSwitch();

                                              }
                                            } on FirebaseAuthException catch (e) {
                                              if (e.code == 'user-not-found') {
                                                customSnackBar(text: '${e.message}', context: context);
                                              } else if (e.code == 'wrong-password') {
                                                customSnackBar(text: '${e.message}', context: context);
                                              } else if (e.code == 'email-already-in-use') {
                                                customSnackBar(text: '${e.message}', context: context);
                                              } else if (e.code == 'network-request-failed') {
                                                customSnackBar(text: '${e.message}', context: context);
                                              } else if(e.code == 'invalid-email'){
                                                customSnackBar(text: '${e.message}', context: context);
                                              }
                                              prov.read(_loadingProv).trueSwitch();
                                            }

                                            //  return await AuthFunctions.loginAuth(
                                            //     email: _emailController.text ,
                                            //     password: _pwController.text ,
                                            //     globalKey: _globalKey ,
                                            //     route: MainBottomBarScreen.bottomBar ,
                                            //     context: context ,
                                            //     state: prov ,
                                            //     indicatorState: _loadingProv
                                            // );
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
                            );
                          }
                        ) ,

                        GestureDetector(
                          onTap: () async {
                            return await ConstRouters.pushNamedRouter(
                                route: MainSignUpScreen.signUP, context: context);
                          },
                          child: const CustomText(
                            text: 'I don\'t have an Account?' ,
                            color: normalWhite ,
                          ),
                        ) ,

                      ],
                    ),


                    const Spacer(flex: 12,),
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
  final TextEditingController _pwController = TextEditingController();
  final _checkPwProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _loadingProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
}