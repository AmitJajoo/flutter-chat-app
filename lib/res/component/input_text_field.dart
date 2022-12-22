

import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hint;
  final bool enable,autofocus;
  final FormFieldValidator onValidator;
  const InputTextField({
    super.key,
    required this.myController,
    required this.focusNode,
    required this.onFiledSubmittedValue,
    required this.keyboardType,
    required this.obscureText,
    required this.hint,
    this.enable=true,  
    this.autofocus=true,
    required this.onValidator
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        obscureText: obscureText,
        validator: onValidator,
        onFieldSubmitted: onFiledSubmittedValue,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
          height: 0,
          fontSize: 19
        ),

        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: AppColors.primaryTextTextColor.withOpacity(0.8),
            height: 0
          ),
          contentPadding:const EdgeInsets.all(15),
          border:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor)
          ),
          focusedBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.secondaryColor)
          ),
          errorBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.alertColor)
          ),
          enabledBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor)
          )
        ),
      ),
    );
  }
}