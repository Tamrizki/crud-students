import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/app/consts/consts.dart';
import 'package:crud_firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.StreamStudent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              print(snapshot.data);
              final listStudent = snapshot.data!.docs;
              return GestureDetector(
                onTap: () {},
                child: Expanded(
                  child: ListView.builder(
                      itemCount: listStudent.length,
                      itemBuilder: (context, index) {
                        final student =
                            listStudent[index].data() as Map<String, dynamic>;
                        return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.ADD, arguments: [
                                true,
                                listStudent[index].id
                              ]);
                            },
                            child: studentItem(student, listStudent, index));
                      }),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD);
        },
        child: Icon(Icons.person_add_alt),
      ),
    );
  }

  Container studentItem(Map<String, dynamic> student,
      List<QueryDocumentSnapshot<Object?>> listStudent, int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: ListTile(
        tileColor: Colors.lightBlue.shade50,
        title: Text(student[Txt.name]),
        subtitle: Text((student[Txt.gender].toString().toLowerCase() == 'l')
            ? 'Male'
            : 'Female'),
        leading: Icon(Icons.person),
        trailing: GestureDetector(
            onTap: () {
              Get.defaultDialog(
                  title: 'Delete ',
                  middleText:
                      'Are you sure you want to delete ${student[Txt.name]}',
                  textConfirm: 'Yes',
                  textCancel: 'Cancle',
                  onConfirm: () {
                    Get.back();
                    controller.deleteData(listStudent[index].id);
                  });
            },
            child: Icon(
              Icons.remove_circle,
              color: Colors.red,
            )),
      ),
    );
  }

  FutureBuilder<QuerySnapshot<Object?>> getStudentOneTime() {
    return FutureBuilder<QuerySnapshot<Object?>>(
      future: controller.getStudent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          final listStudent = snapshot.data!.docs;
          return ListView.builder(
              itemCount: listStudent.length,
              itemBuilder: (context, index) {
                final student =
                    listStudent[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(student[Txt.name]),
                  subtitle: Text(
                      (student[Txt.gender].toString().toLowerCase() == 'l')
                          ? 'Male'
                          : 'Female'),
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
