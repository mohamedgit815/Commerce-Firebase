import 'package:flutter/cupertino.dart';

final RegExp regExpEmail =
RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

final RegExp regExpPw = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

final RegExp regExpPhone = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

final RegExp regExpName = RegExp('[a-zA-Z]');

final RegExp regexImage =  RegExp(r"(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png)");

final PageStorageBucket pageStorageBucket = PageStorageBucket();

const String pathAssets = 'assets/images';