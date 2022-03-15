import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {

  final ValueChanged<String>? onChange , onSubmitted;
  final ValueChanged? onSave ;
  final FormFieldValidator<String> validator;
  final Widget? suffixIcon , prefixIcon;
  final Color? suffixIconColor , prefixIconColor , fillColor;
  final String? label , hint ;
  final bool? password ;
  final TextInputAction inputAction ;
  final TextInputType inputType ;
  final TextEditingController? controller ;

  const DefaultTextFormField({
    Key? key,
    required this.validator ,
    required this.inputType ,
    required this.inputAction ,
    this.onChange ,
    this.onSave ,
    this.controller ,
    this.onSubmitted ,
    this.password ,
    this.suffixIcon ,
    this.prefixIcon ,
    this.suffixIconColor ,
    this.prefixIconColor ,
    this.fillColor ,
    this.label ,
    this.hint
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      autocorrect: true ,
      onChanged: onChange ,
      validator: validator ,
      textDirection: TextDirection.ltr,
      onSaved: onSave,
      keyboardType: inputType ,
      cursorColor: _theme.backgroundColor,
      textInputAction: inputAction ,
      onFieldSubmitted: onSubmitted ,
      obscureText: password ?? false ,
      autofocus: false,
      decoration: InputDecoration(
        filled: true ,
        fillColor: fillColor ,
        suffixIconColor: suffixIconColor ,
        prefixIconColor: prefixIconColor ,
        suffixIcon: suffixIcon ,
        prefixIcon: prefixIcon ,
        labelText: label ,
        hintText: hint
      ),
    );
  }
}
