import 'dart:math';

import 'package:attendify/app/data/model/attend_status.dart';
import 'package:attendify/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/lib/app/utils/firebase_humanize_error_code.dart';

class AttendanceController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var name = "-".obs;
  AttendStatus lastAttendStatus = AttendStatus(type: "-", date: "-", time: "-");

  var isLoading = false.obs;
  String? errorMessage;

  @override
  void onInit() {
    super.onInit();
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

  Stream<AttendStatus> getLastStatus() {
    return firestore
        .collection('attends')
        .doc(auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      List<dynamic> rawData = snapshot.data()?["attendance"];
      List<AttendStatus> attendanceLogs = rawData
          .map((data) => AttendStatus.fromJson(data))
          .toList()
          .reversed
          .toList();
      return attendanceLogs[0];
    });
  }

  Stream<List<AttendStatus>> getAttendLogs() {
    return firestore
        .collection('attends')
        .doc(auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      List<dynamic> rawData = snapshot.data()?["attendance"];
      List<AttendStatus> attendanceLogs = rawData
          .map((data) => AttendStatus.fromJson(data))
          .toList()
          .reversed
          .toList();
      return attendanceLogs;
    });
  }

  Stream<String> getName() {
    return firestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.data()?["name"];
    });
  }

  void onCheckIn() async {
    isLoading.value = true;

    try {
      var logs = AttendStatus(
          type: "Check In",
          date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          time: DateFormat("hh:mm a'").format(DateTime.now()));

      await firestore
          .collection("attends")
          .doc(auth.currentUser?.uid)
          .get()
          .then((DocumentSnapshot document) async {
        if (document.exists) {
          await firestore
              .collection("attends")
              .doc(auth.currentUser?.uid)
              .update({
            "attendance": FieldValue.arrayUnion([logs.toJson()])
          });
        } else {
          await firestore.collection("attends").doc(auth.currentUser?.uid).set({
            "attendance": FieldValue.arrayUnion([logs.toJson()])
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
      title: errorMessage == null ? "Succes Check In" : "Error Check In",
      middleText: errorMessage == null
          ? "Check-in successful! Welcome back. Have a productive and enjoyable day. Happy working!"
          : "Failed to add because : $errorMessage",
      onConfirm: () {
        Get.back();
      },
    );
  }

  void onCheckOut() async {
    isLoading.value = true;

    try {
      var logs = AttendStatus(
          type: "Check Out",
          date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          time: DateFormat("hh:mm a'").format(DateTime.now()));

      await firestore
          .collection("attends")
          .doc(auth.currentUser?.uid)
          .get()
          .then((DocumentSnapshot document) async {
        if (document.exists) {
          await firestore
              .collection("attends")
              .doc(auth.currentUser?.uid)
              .update({
            "attendance": FieldValue.arrayUnion([logs.toJson()])
          });
        } else {
          await firestore.collection("attends").doc(auth.currentUser?.uid).set({
            "attendance": FieldValue.arrayUnion([logs.toJson()])
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
      title: errorMessage == null ? "Succes Check Out" : "Error Check Out",
      middleText: errorMessage == null
          ? "Check-out successful! Thank you for your hard work today. Have a great rest of your day!"
          : "Failed to add because : $errorMessage",
      onConfirm: () {
        Get.back();
      },
    );
  }

  void onRefresh() async {
    isLoading.value = true;

    await firestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .get()
        .then((DocumentSnapshot document) {
      if (document.exists) {
        name.value = document["name"];
      } else {
        name.value = "-";
        Get.defaultDialog(
          title: "Welcome new user",
          middleText:
              "Please setup your account on profile section. Please fill the name and your job",
          onConfirm: () {
            Get.back();
          },
        );
      }
    });

    isLoading.value = false;
  }

  void onLogout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are u sure want to logout?",
      onConfirm: () async {
        await auth.signOut();
        Get.offAllNamed(Routes.LOGIN);
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
