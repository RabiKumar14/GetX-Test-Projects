import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test_project/controllers/auth_controller.dart';
import 'package:getx_test_project/views/background_layer_view.dart';
import 'package:getx_test_project/widgets/hero_title.dart';
import 'package:getx_test_project/widgets/rounded_button.dart';
import 'package:getx_test_project/widgets/rounded_text_formfield.dart';
import 'package:getx_test_project/widgets/text_button.dart';

import '../constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const HeroTitle(
                  title: 'Sign Up',
                  subtitle: 'Create an account...',
                ),
                buildTextFormFields(),
                SignUpButtons(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildTextFormFields() {
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 8,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(height: height * 0.08),
          ),
          RoundedTextFormField(
            controller: _nameController,
            hintText: 'Name',
            validator: (value) {
              if (value.toString().length <= 2) {
                return 'Enter valid name.';
              }
              return null;
            },
          ),
          SizedBox(height: height * 0.02),
          RoundedTextFormField(
            controller: _emailController,
            hintText: 'Email',
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
          SizedBox(height: height * 0.02),
          RoundedTextFormField(
            controller: _passwordController,
            obsecureText: true,
            hintText: 'Password',
            validator: (value) {
              if (value.toString().length < 6) {
                return 'Password should be longer or equal to 6 characters.';
              }
              return null;
            },
          ),
          SizedBox(height: height * 0.02),
          RoundedTextFormField(
            obsecureText: true,
            hintText: 'Confirm Password',
            validator: (value) {
              if (value!.trim() != _passwordController.text.trim()) {
                return 'Passwords does not match!';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class SignUpButtons extends StatelessWidget {
  const SignUpButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _nameController = nameController,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: height * 0.02),
          RoundedElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String name = _nameController.text.trim();
                String email = _emailController.text.trim();
                String password = _passwordController.text;
                _authController.signUp(name, email, password);
              }
            },
            title: 'Sign up',
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.38,
              vertical: height * 0.02,
            ),
          ),
          TextWithTextButton(
            text: 'Already have an account?',
            textButtonText: 'Sign in',
            onPressed: () => Get.offAll(() => const BgView()),
          ),
        ],
      ),
    );
  }
}
