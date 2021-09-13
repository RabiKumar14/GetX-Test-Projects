import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test_project/controllers/auth_controller.dart';
import 'package:getx_test_project/widgets/hero_image.dart';
import 'package:getx_test_project/widgets/hero_title.dart';
import 'package:getx_test_project/widgets/rounded_button.dart';
import 'package:getx_test_project/widgets/rounded_text_formfield.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ),
            const HeroTitle(
                title: 'Recovery', subtitle: 'Please enter you account email'),
            SizedBox(height: height * 0.05),
            const HeroImage(
                path: 'assets/resetHero.svg', sementicLabel: 'Reset Hero'),
            SizedBox(height: height * 0.05),
            const ResetForm(),
            SizedBox(height: height * 0.2),
          ],
        ),
      )),
    );
  }
}

class ResetForm extends StatelessWidget {
  const ResetForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();

    final _authController = Get.find<AuthController>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          RoundedTextFormField(
            hintText: 'Email',
            controller: _emailController,
            validator: (value) {
              bool _isEmailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (!_isEmailValid) {
                return 'Invalid email.';
              }
              return null;
            },
          ),
          SizedBox(height: height * 0.03),
          RoundedElevatedButton(
            title: 'Reset Password',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _authController.resetPassword(_emailController.text.trim());
              }
            },
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.32, vertical: height * 0.02),
          ),
        ],
      ),
    );
  }
}
