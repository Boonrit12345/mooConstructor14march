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

  // CREATE DATA
  Future<void> addData(carData) async {
    if (isLoggedIn()) {
      Firestore.instance
          .collection('ImageDailyReport')
          .add(carData)
          .catchError((e) {
        print(e);
      });
    } else {
      // ถ้ายังไม่ Log in แจ้งให้ Log in
      print('You need to be logged in');
    }
  }

// เรียกดูรูปถ่ายประจำวัน
  getData(selectedDoc) async {
    return await Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyImage')
        .orderBy('dateImage',
            descending: true) // เรียงข้อมูลมากไปน้อย ตาม column field
        .snapshots();
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

//  DELETE Daily Progress
  deleteDataDailyProgress(selectedDoc, docId) {
    Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyReport')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
    print('Work in ===>> deleteDataDailyProgress');
  }
}

// จบ
