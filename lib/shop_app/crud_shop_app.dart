import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudShopAppMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(carData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('itccrud').add(carData).catchError((e) {
        print(e);
      });
    } else {
      print('You need to be logged in');
    }
  }

// CREATE DATA
  getData() async {
    // return await Firestore.instance.collection('testcrud').getDocuments();
    return await Firestore.instance.collection('itccrud').snapshots();
  }


// UPDATE
  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('itccrud')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }
 
//  DELETE
  deleteData(docId) {
    Firestore.instance
        .collection('itccrud')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }


}



// จบ
