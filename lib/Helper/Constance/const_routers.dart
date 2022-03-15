import 'package:flutter/material.dart';


class ConstRouters {

  static Future<dynamic> backPageRouter(BuildContext context) async {
    return await Navigator.of(context).maybePop();
  }

  static Future<dynamic> pushNamedRouter({required String route ,required BuildContext context}) async {
    return await Navigator.of(context).pushNamed(route);
  }

  static Future<dynamic> pushNamedAndReplaceRouter({required String route ,required BuildContext context}) async {
    return await Navigator.of(context).pushReplacementNamed(route);
  }

  static Future<dynamic> pushNamedAndRemoveRouter({required String route ,required BuildContext context}) async {
    return await Navigator.of(context).pushNamedAndRemoveUntil(route , (route) => false);
  }

}