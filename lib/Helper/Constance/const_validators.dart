import 'package:commerce/Helper/Constance/const_regexp.dart';

class ConstValidators {
  static String? validatorName(String? v) {
    return !v!.contains(regExpName) ? 'Enter your Name by write form' : null ;
  }

  static String? validatorEmail(String? v) {
    return !v!.contains(regExpEmail) ? 'Enter your Email by write form' : null ;
  }

  static String? validatorPhone(String? v) {
    return !v!.contains(regExpPhone) ? 'Enter your Phone by write form' : null;
  }

  static String? validatorPw(String? v) {
    return !v!.contains(regExpPw) ? '[UpperCase , LowerCase , \$ ,# ,%]' : null;
  }
}