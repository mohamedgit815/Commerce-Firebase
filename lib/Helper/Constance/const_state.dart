import 'package:commerce/Update/State/lang_state.dart';
import 'package:commerce/Update/State/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeProv = ChangeNotifierProvider((ref)=>ThemeState());
final langProv = ChangeNotifierProvider((ref)=>LangState());

