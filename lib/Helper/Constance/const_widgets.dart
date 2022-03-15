import 'package:commerce/Helper/Constance/const_colors.dart';
import 'package:commerce/Update/State/switch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConstWidgets {
  static IconButton iconButtonVisibility({
    required WidgetRef ref ,
    required IconData icon ,
    required ChangeNotifierProvider<SwitchState> state ,
    VoidCallback? onPressed ,
    Color? color ,
  }){
    return IconButton(
        onPressed: onPressed ?? (){
          ref.read(state).funcSwitch();
        },
        icon: Icon(icon,color: color ?? normalWhite ));
  }
}