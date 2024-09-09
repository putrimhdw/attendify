import 'package:attendify/app/data/model/user_related.dart';
import 'package:attendify/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/lib/app/utils/firebase_humanize_error_code.dart';

class AccountSettingController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final jobController = TextEditingController();

  String? errorMessage;

  var isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();

    if (auth.currentUser == null) {
      Get.defaultDialog(
        title: "Your not login",
        middleText: "Please login to verify your account changes",
        onConfirm: () {
          Get.toNamed(Routes.LOGIN);
        },
      );
    }

    onRefresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onUpdateAccount() async {
    isLoading.value = true;

    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser?.uid)
          .get()
          .then((DocumentSnapshot document) async {
        if (document.exists) {
          await firestore
              .collection("users")
              .doc(auth.currentUser?.uid)
              .update({
            "name": nameController.text,
            "job": jobController.text,
          });
        } else {
          await firestore.collection("users").doc(auth.currentUser?.uid).set({
            "name": nameController.text,
            "job": jobController.text,
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      errorMessage =
          firebaseHumanizeErrorCode(e.code) ?? "Unexpected Error Occured";
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading.value = false;

    Get.defaultDialog(
      title: errorMessage == null
          ? "Success update account"
          : "Error update account",
      middleText: errorMessage == null
          ? "Update account is success! Don't forget to add your attendance"
          : "Failed to update because : $errorMessage",
      onConfirm: () {
        Get.back();
        Get.back();
      },
    );
  }

  void onRefresh() {
    isLoading.value = true;

    firestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .get()
        .then((DocumentSnapshot document) {
      if (document.exists) {
        emailController.text = auth.currentUser?.email ?? "-";
        nameController.text = document["name"];
        jobController.text = document["job"];
      }
    });

    isLoading.value = false;
  }

  String? onNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Name can't be empty";
    }
    return null;
  }

  String? onJobValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Job can't be empty";
    }
    return null;
  }
}
