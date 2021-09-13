import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test_project/controllers/auth_controller.dart';
import 'package:getx_test_project/views/home.dart';
import 'package:getx_test_project/views/sign_in.dart';

class BgView extends StatelessWidget {
  const BgView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: GetBuilder<AuthController>(
        builder: (_) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: _.userProfile != null ? const Home() : const SignIn(),
            ),
          );
        },
      ),
    );
  }
}
