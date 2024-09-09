import 'package:attendify/app/data/model/request_extra.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/lib/app/utils/firebase_humanize_error_code.dart';

class RequestLeaveController extends GetxController {
  var selectedDate = DateTime.now().obs;
  final dateController = TextEditingController();
  final reasonController = TextEditingController();

  var isLoading = false.obs;
  String? errorMessage;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onSubmitLeave() async {
    isLoading.value = true;

    try {
      var leave = RequestExtra(
          date: dateController.text,
          reason: reasonController.text,
          type: "Leave");

      await firestore
          .collection("request")
          .doc(auth.currentUser?.uid)
          .get()
          .then((DocumentSnapshot document) async {
        if (document.exists) {
          await firestore
              .collection("request")
              .doc(auth.currentUser?.uid)
              .update({
            "request": FieldValue.arrayUnion([leave.toJson()])
          });
        } else {
          await firestore.collection("request").doc(auth.currentUser?.uid).set({
            "request": FieldValue.arrayUnion([leave.toJson()])
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
      title:
          errorMessage == null ? "Succes to request leaves" : "Error Request",
      middleText: errorMessage == null
          ? "Request successful added! Please stay tune on your request status"
          : "Failed to add because : $errorMessage",
      onConfirm: () {
        Get.back();
        Get.back();
      },
    );
  }

  void selectDate() async {
    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateController.text =
          DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();
    }
  }
}
