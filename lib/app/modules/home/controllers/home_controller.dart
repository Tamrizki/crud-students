import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/app/data/firebase/fb_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  bool isLoading = true;

  @override
  void onInit() {
    getStudent();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<QuerySnapshot<Object?>> getStudent() => FirebaseService().getStudent();

  Stream<QuerySnapshot<Object?>> StreamStudent() =>
      FirebaseService().streamStudents();

  void deleteData(String id) async {
    FirebaseService().deleteData(id).then((value) {
      isLoading = false;
      Get.defaultDialog(
        title: 'Delete',
        middleText: 'Success deleted data',
        textConfirm: 'Ok',
        onConfirm: () {
          Get.back();
        } 
      );
    }).catchError((e) {
      isLoading = false;
    });
  }
}
