import 'package:attendify/app/data/model/request_extra.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RequestController extends GetxController {
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

  Stream<List<RequestExtra>> getRequestData() {
    return firestore
        .collection('request')
        .doc(auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      List<dynamic> rawData = snapshot.data()?["request"];
      List<RequestExtra> request = rawData
          .map((data) => RequestExtra.fromJson(data))
          .toList()
          .reversed
          .toList();
      return request;
    });
  }
}
