import 'package:flutter/material.dart';
import 'package:getx_test_project/constants.dart';

class RoundedElevatedButton extends StatelessWidget {
  const RoundedElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String? title;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title!,
        style: TextStyle(fontSize: width * 0.04),
      ),
      style: ElevatedButton.styleFrom(
        padding: padding,
        primary: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
