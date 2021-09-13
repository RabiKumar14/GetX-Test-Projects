import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test_project/controllers/auth_controller.dart';
import 'package:getx_test_project/widgets/hero_title.dart';
import 'package:getx_test_project/widgets/rounded_button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: GetBuilder<AuthController>(
      builder: (_authController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeroTitle(
                title:
                    'Hello ${_authController.displayName.toString().capitalizeString()}!',
                subtitle: 'Let\'s being...'),
            Expanded(flex: 8, child: Container()),
            RoundedElevatedButton(
              title: 'Sign out',
              onPressed: () => _authController.signout(),
              padding: EdgeInsets.symmetric(horizontal: width * 0.2),
            ),
          ],
        );
      },
    ));
  }
}
