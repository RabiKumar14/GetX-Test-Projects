import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_test_project/constants.dart';
import 'package:getx_test_project/views/background_layer_view.dart';

class AuthController extends GetxController {
  var displayName = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    displayName = userProfile != null ? userProfile!.displayName! : '';

    super.onInit();
  }

  void signUp(String name, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayName = name;
        auth.currentUser!.updateDisplayName(name);
      });

      update();
      Get.offAll(() => const BgView());
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    }
  }

  void signIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => displayName = userProfile!.displayName!);

      update();
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'wrong-password') {
        message = 'Invalid Password. Please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    } catch (e) {
      Get.snackbar(
        'Error occured!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kPrimaryColor,
        colorText: kBackgroundColor,
      );
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    }
  }

  void signout() async {
    try {
      await auth.signOut();
      displayName = '';
      update();
      Get.offAll(() => const BgView());
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    }
  }
}

extension StringExtension on String {
  String capitalizeString() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
