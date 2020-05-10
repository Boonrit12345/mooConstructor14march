import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudExampleMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

// Create Data
  Future<void> addData(carData) async {
    if (isLoggedIn()) {
      // Firestore.instance.collection('Examplecrud').add(carData).catchError((e) {
      //   print(e);
      // });

      Firestore firestore = Firestore.instance;
      await firestore
          .collection('ItcTest')  // ชื่อแฟ้มงาน
          .document('Doc_1')      // ID เอกสาร
          .collection('Collection_2')  // ชื่อแฟ้มย่อย 2
          .document('Doc_A')           // ID แฟ้มย่อย 2
          .collection('items_A')  // กระดาษ A
          .document()             // ID บรรทัด
          .setData(carData)   // ข้อมูลในบรรทัด
          .then((value) {
        print('================== >>>>>>>>>>> Create data is success');
      });
    } else {
      print('You need to be logged in');
    }
  }

// Read Data
  getData() async {
    return await Firestore.instance.collection('ItcTest').snapshots();

    // return await Firestore.instance
    //     .collection('DailyReport') // เลือกข้อมูลจากตาราง DailyReport
    //     .where('field',isEqualTo: 'field') // กรองค่าเฉพาะ field
    //     .where('field2',isEqualTo: 'field2') // กรองค่าเฉพาะ field2
    //     .orderBy('field',descending: true) // เรียงข้อมูลมากไปน้อย ตาม column field
    //     .getDocuments();


  }

// Update Data
  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('ItcTest')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

// Delete Data
  deleteData(docId) {
    Firestore.instance
        .collection('ItcTest')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
