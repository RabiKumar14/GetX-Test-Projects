import 'package:flutter/material.dart';
import 'package:getx_test_project/constants.dart';

class RoundedTextFormField extends StatelessWidget {
  const RoundedTextFormField({
    Key? key,
    this.controller,
    this.obsecureText = false,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool? obsecureText;
  final String? hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText!,
      decoration: InputDecoration(
        hintText: hintText!,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kErrorColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kErrorColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
