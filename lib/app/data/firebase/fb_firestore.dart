import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/app/consts/consts.dart';
import 'package:crud_firebase/app/data/models/student.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(Student data) {
    return students.add({
      Txt.name: data.name,
      Txt.number: data.number,
      Txt.gender: data.gender
    });
  }

  Future<QuerySnapshot<Object?>> getStudent() async {
    return students.orderBy('number').get();
  }

  Stream<QuerySnapshot<Object?>> streamStudents() {
    return students.snapshots();
  }

  Future<void> deleteData(String id) async {
    return students.doc(id).delete();
  }

  Future<void> updateStudent(String id, Student data) async {
    return students.doc(id).update({
      Txt.name: data.name,
      Txt.number: data.number,
      Txt.gender: data.gender
    });
  }

  Future<DocumentSnapshot<Object?>> getStudentById(String id) async {
    return students.doc(id).get();
  }
}
