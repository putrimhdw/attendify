import 'package:attendify/app/data/model/user_related.dart';
import 'package:attendify/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final storageSecure = const FlutterSecureStorage();
  final LocalAuthentication localAuth = LocalAuthentication();

  var useBiometrics = false.obs;

  var isLoading = false.obs;
  late UserRelated user;

  @override
  void onInit() {
    super.onInit();
    user = UserRelated.fromJson({
      "name": "-",
      "job": "-",
      "email": auth.currentUser?.email,
    });

    getUserData();
    loadBiometricPreference();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void getUserData() async {
  //   isLoading.value = true;

  //   await firestore
  //       .collection("users")
  //       .doc(auth.currentUser?.uid)
  //       .get()
  //       .then((DocumentSnapshot document) {
  //     if (document.exists) {
  //       user.name = document["name"];
  //       user.job = document["job"];
  //     }
  //   });

  //   isLoading.value = false;
  // }

  Stream<UserRelated> getUserData() {
    return firestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      return UserRelated(
          name: snapshot.data()?["name"] ?? "-",
          job: snapshot.data()?["job"] ?? "-",
          email: auth.currentUser?.email ?? "");
    });
  }

  Future<void> loadBiometricPreference() async {
    final value = await storageSecure.read(key: 'use_biometrics');
    useBiometrics.value = value == 'true';
  }

  Future<void> toggleBiometrics(bool value) async {
    if (value) {
      final isAvailable = await localAuth.canCheckBiometrics;
      if (!isAvailable) {
        Get.snackbar("Biometric", "Biometric not available on this device");
        return;
      }

      try {
        final didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Enable biometric login',
          options: const AuthenticationOptions(),
        );
        if (didAuthenticate) {
          // Save credentials (email/password) securely if needed
          await storageSecure.write(key: 'use_biometrics', value: 'true');
          useBiometrics.value = true;
        }
      } on PlatformException catch (e) {
        Get.snackbar("Not Supported", e.toString());
      }
    } else {
      await storageSecure.write(key: 'use_biometrics', value: 'false');
      useBiometrics.value = false;
    }
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
