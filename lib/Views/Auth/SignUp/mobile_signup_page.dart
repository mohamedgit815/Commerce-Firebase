import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_routers.dart';
import 'package:commerce/Helper/Constance/const_validators.dart';
import 'package:commerce/Helper/Constance/const_widgets.dart';
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


class MobileSignUpPage extends ConsumerStatefulWidget {
  const MobileSignUpPage({Key? key}) : super(key: key);

  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends ConsumerState<MobileSignUpPage> with _MixinMobileSignUp{
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

                  const Spacer(flex: 12),

                  Column(
                    children: [
                      DefaultExpandedAuth(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 12,
                              child: DefaultAuthFormField(
                                hintText: 'First Name' ,
                                inputType: TextInputType.text ,
                                inputAction: TextInputAction.next ,
                                validator: (String? v) {
                                  return ConstValidators.validatorName(v);
                                },

                                controller:  _firstController ,

                              ),
                            ) ,

                            const Spacer(flex: 1,),

                            Expanded(
                              flex: 12,
                              child: DefaultAuthFormField(
                                hintText: 'Last Name' ,
                                inputType: TextInputType.text ,
                                inputAction: TextInputAction.next ,
                                validator: (String? v) {
                                  return ConstValidators.validatorName(v);
                                } ,

                                controller:  _lastController ,

                              ),
                            )
                          ],
                        ) ,
                      ) ,

                      const SizedBox(height: 10.0) ,

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
                              condition: prov.read(_checkPwProv).varSwitch,
                              builder: (BuildContext context){
                                return ConstWidgets.iconButtonVisibility(ref: prov,icon: Icons.visibility_off,state: _checkPwProv);
                              },
                              fallback: (BuildContext context){
                                return ConstWidgets.iconButtonVisibility(ref: prov,icon: Icons.visibility,state: _checkPwProv);
                              },
                            ) ,
                            validator: (String? v) {
                              return v!.isEmpty ? 'Enter your Password by right Form': null;
                            },

                            controller:  _pwController ,
                            onSubmitted: (v) async {
                              FocusScope.of(context).unfocus();

                              return await AuthFunctions.registerAuth(
                                  email: _emailController.text ,
                                  password: _pwController.text ,
                                  globalKey: _globalKey ,
                                  route: MainLoginScreen.login ,
                                  context: context ,
                                  state: ref ,
                                  indicatorState: _loadingProv ,
                                  first: _firstController.text ,
                                  last: _lastController.text
                              );
                            },
                          ),
                        ),
                      ) ,

                    ],
                  ) ,

                  const Spacer(flex: 1),

                  Column(
                    children: [

                      Consumer(
                        builder:( context , prov , _ ) => AnimatedConditionalBuilder(
                            condition: prov.watch(_loadingProv).varSwitch,
                            builder: (BuildContext context) {
                              return DefaultExpandedAuth(
                                  child: CustomTextButton(
                                    child: CustomText(
                                      text: 'Sign Up' ,
                                      color: constGradient.colors.first ,
                                      fontSize: 17.0 ,
                                      fontWeight: FontWeight.bold ,
                                    ),
                                    onPressed: () async {

                                      FocusScope.of(context).unfocus();

                                      return await AuthFunctions.registerAuth(
                                          email: _emailController.text ,
                                          password: _pwController.text ,
                                          globalKey: _globalKey ,
                                          route: MainLoginScreen.login ,
                                          context: context ,
                                          state: prov ,
                                          indicatorState: _loadingProv ,
                                          first: _firstController.text ,
                                          last: _lastController.text
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
                          text: 'i have an Account' ,
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

mixin _MixinMobileSignUp {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final _checkPwProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _loadingProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
}