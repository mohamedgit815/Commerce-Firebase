import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Helper/Constance/const_regexp.dart';
import 'package:commerce/Helper/Constance/const_text.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_button.dart';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:commerce/Helper/Widgets/Defaults/default_textformfield.dart';
import 'package:commerce/Helper/Widgets/Defaults/defualt_expandedauth.dart';
import 'package:commerce/Update/Functions/auth_functions.dart';
import 'package:commerce/Update/State/switch_state.dart';
import 'package:commerce/Views/Main/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileChangePwPage extends ConsumerStatefulWidget {
  const MobileChangePwPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileChangePwPage> createState() => _MobileChangePwPageState();
}

class _MobileChangePwPageState extends ConsumerState<MobileChangePwPage>
with _MobileChangePw {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: '${translateText(textChange, context)}',
          fontSize: 20.0,
          color: lightMainColor,
        ),
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            DefaultExpandedAuth(
              child: Consumer(
                builder:(context,_prov,_)=> AnimatedConditionalBuilder(
                  duration: const Duration(milliseconds: 250),
                    condition: _prov.watch(_switchProv).varSwitch,
                    builder: (BuildContext context){
                      return Consumer(
                        builder:(context,provOld,_)=> DefaultTextFormField(
                          onChange: (String v){
                             oldPw = v;
                          },
                            validator: (v){
                              return !regExpPw.hasMatch(v.toString()) ? 'Check your old Password' : null;
                            },
                          password: provOld.watch(_visibilityProv).varSwitch,
                            inputType: TextInputType.visiblePassword,
                            inputAction: TextInputAction.done,
                          hint: 'Enter your old Password',
                          onSubmitted: (v) async {
                           return await AuthFunctions.checkOldPassword(
                                old: oldPw,
                                ref: ref,
                                state: _switchProv,
                                context: context,
                               globalKey: _globalKey,
                               indicatorState: _oldIndicatorProv
                            );
                          },
                          suffixIcon: IconButton(
                              onPressed: (){
                                provOld.read(_visibilityProv).funcSwitch();
                              },
                              icon: AnimatedConditionalBuilder(
                                condition: provOld.read(_visibilityProv).varSwitch,
                                builder: (BuildContext context)=>const Icon(Icons.visibility),
                                fallback: (BuildContext context)=>const Icon(Icons.visibility_off_sharp),
                              )
                          ),
                        ),
                      );
                    },
                    fallback: (BuildContext context){
                      return Consumer(
                        builder:(context,provNew,_)=> DefaultTextFormField(
                          onChange: (String v){
                            newPw = v;
                          },
                          validator: (v){
                            return !regExpPw.hasMatch(v.toString()) ? '[UpperCase , LowerCase , @!#\$]' : null;
                          },
                          suffixIcon: IconButton(
                              onPressed: (){
                                provNew.read(_visibilityProv).funcSwitch();
                              },
                              icon: AnimatedConditionalBuilder(
                                condition: provNew.read(_visibilityProv).varSwitch,
                                builder: (BuildContext context)=>const Icon(Icons.visibility),
                                fallback: (BuildContext context)=>const Icon(Icons.visibility_off_sharp),
                              )
                          ),
                          onSubmitted: (v) async {
                            await AuthFunctions.changePassword(
                                newPw: newPw,
                                context: context,
                                globalKey: _globalKey,
                                widgetRef: ref,
                                indicatorState: _newIndicatorProv
                            );
                          },
                          inputType: TextInputType.visiblePassword,
                          inputAction: TextInputAction.done,
                          hint: 'Enter New Password',
                        ),
                      );
                    },),
              ),
            ),



            DefaultExpandedAuth(
              child: Consumer(
                builder:(context,_checkPwProv,_)=> AnimatedConditionalBuilder(
                  duration: const Duration(milliseconds: 250),
                  condition: _checkPwProv.watch(_switchProv).varSwitch,
                  builder:(context)=> CustomElevatedButton(
                      onPressed: () async {
                        return await AuthFunctions.checkOldPassword(
                            old: oldPw ,
                            ref: _checkPwProv ,
                            state: _switchProv ,
                            context: context ,
                            globalKey: _globalKey,
                            indicatorState: _oldIndicatorProv
                        );
                  }, child: const CustomText(text: 'Check Password',)),
                  fallback: (context)=>CustomElevatedButton(
                      onPressed: () async {
                        return await AuthFunctions.changePassword(
                            newPw: newPw ,
                            context: context ,
                            globalKey: _globalKey,
                            indicatorState: _newIndicatorProv,
                            widgetRef: _checkPwProv
                        );
                      }, child: const CustomText(text: 'Updated Password',)),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

mixin _MobileChangePw {
  final _switchProv = ChangeNotifierProvider((ref)=>SwitchState());
  final _oldIndicatorProv = ChangeNotifierProvider((ref)=>SwitchState());
  final _newIndicatorProv = ChangeNotifierProvider((ref)=>SwitchState());
  final _visibilityProv = ChangeNotifierProvider((ref)=>SwitchState());
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late String newPw = '' , oldPw = '';

}

