import 'package:attendify/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../utils/lib/app/utils/firebase_humanize_error_code.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordObscure = true.obs;
  var isLoading = false.obs;
  String? errorMessage;

  final auth = FirebaseAuth.instance;

  final LocalAuthentication localAuth = LocalAuthentication();

  final storageSecure = const FlutterSecureStorage();

  var useBiometrics = false.obs;

  @override
  void onInit() {
    super.onInit();

    loadBiometricPreference();
  }

  Future<void> loadBiometricPreference() async {
    final value = await storageSecure.read(key: 'use_biometrics');
    useBiometrics.value = value == 'true';
  }

  Future<void> tryBiometricLogin() async {
    final useBiometrics = await storageSecure.read(key: 'use_biometrics');
    if (useBiometrics == 'true') {
      final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        // Sign in user silently
        // Only works if you securely stored credentials or used signInWithCustomToken
        final email = await storageSecure.read(key: 'email');
        final password = await storageSecure.read(key: 'password');

        print(email);
        print(password);

        if (email != null && password != null) {
          isLoading.value = true;
          try {
            await auth.signInWithEmailAndPassword(
                email: email, password: password);
          } on FirebaseAuthException catch (e) {
            errorMessage =
                firebaseHumanizeErrorCode(e.code) ?? "Unexpected Error Occured";
          } catch (e) {
            errorMessage = e.toString();
          }
          isLoading.value = false;
          Get.defaultDialog(
            title: errorMessage == null ? "Succes" : "Error",
            middleText: errorMessage == null
                ? "Success to login on Attendify"
                : "$errorMessage",
            onConfirm: () {
              Get.offAllNamed(Routes.HOME);
            },
          );
        }
      }
    }
  }

  Future<void> saveCredentials(String email, String password) async {
    await storageSecure.write(key: 'email', value: email);
    await storageSecure.write(key: 'password', value: password);
  }

  void onLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      saveCredentials(emailController.text, passwordController.text);
    } on FirebaseAuthException catch (e) {
      errorMessage =
          firebaseHumanizeErrorCode(e.code) ?? "Unexpected Error Occured";
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading.value = false;
    Get.defaultDialog(
      title: errorMessage == null ? "Succes" : "Error",
      middleText: errorMessage == null
          ? "Success to login on Attendify"
          : "$errorMessage",
      onConfirm: () {
        Get.offAllNamed(Routes.HOME);
      },
    );
  }

  void onChangeVisibilitPassword() {
    isPasswordObscure.value = !isPasswordObscure.value;
  }

  String? onEmailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    if (!GetUtils.isEmail(value)) {
      return "Please input the correct email";
    }
    return null;
  }

  String? onPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 8) {
      return "Password can't be less than 8 char";
    }
    return null;
  }
}
