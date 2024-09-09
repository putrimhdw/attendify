import 'package:attendify/app/data/model/user_related.dart';
import 'package:attendify/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

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
