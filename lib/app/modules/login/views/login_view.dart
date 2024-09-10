import 'package:attendify/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width,
                            child: Text(
                              "Sign In",
                              style: Theme.of(context).textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            controller: controller.emailController,
                            validator: controller.onEmailValidation,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              label: Text("Email"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => TextFormField(
                              controller: controller.passwordController,
                              validator: controller.onPasswordValidation,
                              obscureText: controller.isPasswordObscure.value,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                label: Text("Password"),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed:
                                      controller.onChangeVisibilitPassword,
                                  icon: Icon(controller.isPasswordObscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.FORGOT_PASSWORD);
                            },
                            child: Text("Forgot Password"),
                          ),
                          SizedBox(
                            width: Get.width,
                            child: FilledButton(
                              onPressed: controller.onLogin,
                              child: Text("Sign In"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
