import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/app/consts/consts.dart';
import 'package:crud_firebase/app/modules/add/controllers/add_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPage extends GetView<AddController> {
  @override
  Widget build(BuildContext context) {
    late bool isUpdate;
    late String id;
    try {
      isUpdate = Get.arguments[0];
      id = Get.arguments[1];
    } catch (e) {
      isUpdate = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text((!isUpdate) ? 'Input Student' : 'Update Student'),
        actions: [
          GestureDetector(
              onTap: () {
                (isUpdate) ? controller.updateStudent(id) : controller.addStudent();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(Icons.save),
              ))
        ],
      ),
      body: (isUpdate)
          ? FutureBuilder<DocumentSnapshot<Object?>>(
              future: controller.getStudentById(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  dynamic data = snapshot.data?.data();
                  controller.nameC.text = data[Txt.name];
                  controller.numberC.text = data[Txt.number];
                  controller.genderC.text = data[Txt.gender];
                  return FormStudent(controller: controller);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })
          : FormStudent(controller: controller),
    );
  }
}

class FormStudent extends StatelessWidget {
  const FormStudent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AddController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Textfield(
          textController: controller.nameC,
          label: Txt.name,
        ),
        Textfield(
          textController: controller.numberC,
          label: Txt.number,
        ),
        Textfield(
          textController: controller.genderC,
          label: Txt.genderLabel,
          isGender: true,
        ),
      ],
    );
  }
}

class Textfield extends StatelessWidget {
  Textfield(
      {Key? key,
      required this.textController,
      required this.label,
      this.isGender = false})
      : super(key: key);
  final bool isGender;
  final String label;
  final TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: TextField(
        maxLength: (isGender) ? 1 : 18,
        controller: textController,
        decoration: InputDecoration(labelText: label, counterText: ''),
      ),
    );
  }
}
