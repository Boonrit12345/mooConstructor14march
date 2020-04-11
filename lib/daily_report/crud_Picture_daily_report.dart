import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudPictureDailyReportMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  // LOG IN CHECK
  Future<void> addData(carData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('ImageDailyReport').add(carData).catchError((e) {
        print(e);
      });
    } else {
      // ถ้ายังไม่ Log in แจ้งให้ Log in
      print('You need to be logged in');
    }
  }

// CREATE DATA
  getData() async {
    return await Firestore.instance
        .collection('ImageDailyReport')
        .orderBy('dateImage', descending: true) // เรียงข้อมูลมากไปน้อย ตาม column field
        .snapshots();

    // return await Firestore.instance
    //     .collection('DailyReport') // เลือกข้อมูลจากตาราง DailyReport
    //     .where('field',isEqualTo: 'field') // กรองค่าเฉพาะ field
    //     .where('field2',isEqualTo: 'field2') // กรองค่าเฉพาะ field2
    //     .orderBy('field',descending: true) // เรียงข้อมูลมากไปน้อย ตาม column field
    //     .getDocuments();
  }

// UPDATE
  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('ImageDailyReport')
        .document(selectedDoc)
        .updateData(newValues) // คำสั่ง update
        .catchError((e) {
      print(e);
    });
  }

//  DELETE
  deleteData(docId) {
    Firestore.instance
        .collection('ImageDailyReport')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}

// จบ
