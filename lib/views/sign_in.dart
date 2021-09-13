import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test_project/controllers/auth_controller.dart';
import 'package:getx_test_project/views/reset_password.dart';
import 'package:getx_test_project/views/sign_up.dart';
import 'package:getx_test_project/widgets/hero_image.dart';
import 'package:getx_test_project/widgets/hero_title.dart';
import 'package:getx_test_project/widgets/rounded_button.dart';
import 'package:getx_test_project/widgets/rounded_text_formfield.dart';
import 'package:getx_test_project/widgets/text_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // shows header title
        HeroTitle(
          title: 'Welcome!',
          subtitle: 'Enter email and password to login...',
        ),
        // shows image
        HeroImage(
          path: 'assets/svg1.svg',
          sementicLabel: 'Login Hero',
        ),
        // shows textfields and buttons
        SignInForm(),
      ],
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildTextFormFields(),
            SignInButtons(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormFields() {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
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
        SizedBox(height: height * 0.01),
        RoundedTextFormField(
          controller: _passwordController,
          hintText: 'Password',
          obsecureText: true,
          validator: (value) {
            if (value.toString().length < 6) {
              return 'Password should be longer or equal to 6 characters.';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class SignInButtons extends StatelessWidget {
  const SignInButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final _authController = Get.find<AuthController>();

    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.005),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text('Forgot Password?'),
                onPressed: () => Get.to(() => const ResetPassword()),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
              ),
            ),
          ),
          RoundedElevatedButton(
            title: 'Sign in',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String email = _emailController.text.trim();
                String password = _passwordController.text;

                _authController.signIn(email, password);
              }
            },
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.4,
              vertical: height * 0.02,
            ),
          ),
          TextWithTextButton(
            text: 'Don\'t have an account?',
            textButtonText: 'Sign up',
            onPressed: () => Get.to(() => const SignUp()),
          ),
        ],
      ),
    );
  }
}
