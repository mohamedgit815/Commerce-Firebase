import 'dart:core';
import 'package:commerce/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:flutter/material.dart';

MaterialStateProperty<EdgeInsets> materialStatePadding(EdgeInsets padding){
  return MaterialStateProperty.all<EdgeInsets>(padding);
}

MaterialStateProperty<double> materialStateDouble(double double){
  return MaterialStateProperty.all(double);
}

MaterialStateProperty<Size> materialStateSize(Size size){
  return MaterialStateProperty.all<Size>(size);
}

MaterialStateProperty<Color> materialStateColor(Color color){
  return MaterialStateProperty.all<Color>(color);
}

MaterialStateProperty<TextStyle> materialStateStyle(TextStyle style){
  return MaterialStateProperty.all<TextStyle>(style);
}

Center errorProvider(Object err){
  return Center(child: CustomText(text: err.toString(),),);
}

Center loadingProvider(){
  return const Center(child: CircularProgressIndicator.adaptive(),);
}

Center notFoundData(String text){
  return Center(child: CustomText(text: text),);
}