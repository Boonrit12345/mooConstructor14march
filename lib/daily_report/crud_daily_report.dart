import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudDailyReportMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  // ตรวจการ Log in
  Future<void> addData(carData) async {
    if (isLoggedIn()) {
      createData(carData);
    } else {
      // ถ้ายังไม่ Log in แจ้งให้ Log in
      print('You need to be logged in');
    }
  }

// เพิ่มข้อมูล Report
  createData(carData) async {
    Firestore.instance.collection('DailyReport').add(carData).catchError((e) {
      print(e);
    });
  }

// เพิ่มรูปถ่ายประจำวัน
  createDailyImage(selectedDoc,carData) async {
    Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyImage')
        .add(carData)
        .catchError((e) {
      print(e);
    });
  }

// เพิ่มรายงานความก้าวหน้า
  createDailyProgress(selectedDoc,carData) async {
    Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyProgress')
        .add(carData)
        .catchError((e) {
      print(e);
    });
  }

// เพิ่มรายงานพนักงาน
  createDailyStaff(selectedDoc,carData) async {
    Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyStaff')
        .add(carData)
        .catchError((e) {
      print(e);
    });
  }

// เพิ่มรายงานแรงงาน
  createDailyLabor(selectedDoc,carData) async {
    Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyLabor')
        .add(carData)
        .catchError((e) {
      print(e);
    });
  }

// เพิ่มรายงานวัสดุ
  createDailyMaterial(selectedDoc,carData) async {
    Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyMaterial')
        .add(carData)
        .catchError((e) {
      print(e);
    });
  }

// เพิ่มรายงานเครื่องจักร
  createDailyMachine(selectedDoc,carData) async {
    Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyMachine')
        .add(carData)
        .catchError((e) {
      print(e);
    });
  }

// เรียกดู Daily Report
  getData() async {
    return await Firestore.instance
        .collection('DailyReport')
        .orderBy('color', descending: true)
        .snapshots();
  }

// เรียกดู Daily Progress
  getDataDailyProgress(selectedDoc) async {
    return await Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyProgress')
        .orderBy('txttime', descending: false) 
        .snapshots();
  }

// เรียกดู Daily Staff
  getDataDailyStaff(selectedDoc) async {
    return await Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyStaff')
        .orderBy('txttime', descending: false) 
        .snapshots();
  }

// เรียกดู Daily Labor
  getDataDailyLabor(selectedDoc) async {
    return await Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyLabor')
        .orderBy('txttime', descending: false)  
        .snapshots();
  }

// เรียกดู Daily Material
  getDataDailyMaterial(selectedDoc) async {
    return await Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyMaterial')
        .orderBy('txttime', descending: false) 
        .snapshots();
  }

// เรียกดู Daily Machine
  getDataDailyMachine(selectedDoc) async {
    return await Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .collection('DailyMachine')
        .orderBy('txttime', descending: false) 
        .snapshots();
  }







// UPDATE
  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('DailyReport')
        .document(selectedDoc)
        .updateData(newValues) // คำสั่ง update
        .catchError((e) {
      print(e);
    });
  }

//  DELETE
  deleteData(docId) {
    Firestore.instance
        .collection('DailyReport')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

//  DELETE Daily Progress
  deleteDataDailyProgress(selectedDoc,docId) {
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
