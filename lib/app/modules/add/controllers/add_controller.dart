import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/app/data/firebase/fb_firestore.dart';
import 'package:crud_firebase/app/data/models/student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController numberC;
  late TextEditingController genderC;
  late FirebaseService firebase;

  @override
  void onInit() {
    firebase = FirebaseService();
    nameC = TextEditingController();
    numberC = TextEditingController();
    genderC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    numberC.dispose();
    genderC.dispose();
    super.onClose();
  }

  void addStudent() {
    firebase
        .addStudent(Student(
      name: nameC.text,
      gender: genderC.text,
      number: numberC.text,
    ))
        .then((value) {
      nameC.clear();
      genderC.clear();
      numberC.clear();
      Get.back();
      print('===>>> Input data success');
    }).catchError((e) {
      print('===>>> error : $e');
    });
  }

  void updateStudent(String id) {
    firebase
        .updateStudent(
            id,
            Student(
              name: nameC.text,
              gender: genderC.text,
              number: numberC.text,
            ))
        .then((value) {
      nameC.clear();
      genderC.clear();
      numberC.clear();
      Get.back();
      print('===>>> Update data success');
    }).catchError((e) {
      print('===>>> error : $e');
    });
  }

  Future<DocumentSnapshot<Object?>> getStudentById(String id) =>
      FirebaseService().getStudentById(id);
}
