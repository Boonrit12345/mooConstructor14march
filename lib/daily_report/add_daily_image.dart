import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDailyImagePage extends StatefulWidget {
  // final DocumentSnapshot getPost;
  final String getPost;

  AddDailyImagePage({this.getPost});

  @override
  _AddDailyImagePageState createState() => _AddDailyImagePageState();
}

class _AddDailyImagePageState extends State<AddDailyImagePage> {
  //  Explicit
  File file; // เก็บค่ารูปที่เลือกมา
  String _dateImage = "Date*";
  String _titleImage, _explainImage, _unitImage, _urlImageDaily;

  DateTime dateTime;

  // Method
  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
  }

  Future<void> showAlert(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              Container(
                width: 120.0,
                height: 35.0,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue)),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ),
              Container(
                width: 120.0,
                height: 35.0,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue)),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ),
            ],
          );
        });
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object; // เก็บค่ารูปที่ได้ไว้ใน file แล้ว
      });
    } catch (e) {}
  }

  Future<void> uploadPictureToStorage() async {
    // สร้างเลข random เพื่อทำชื่อไฟล์รูป
    Random random = Random();
    int i = random.nextInt(1000000);

    // สร้างตัวแปร instance เพื่อนำไปใช้งาน
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    // สร้างตัวแปร พร้อมเรียกตัวแปรที่ instance พร้อมกำหนดค่าด้วย
    StorageReference storageReference = firebaseStorage
        .ref()
        .child('ImageDailyReport/imagedaily$i.jpg'); // Upload และตั้งชื่อใหม่

    // ขั้นตอนการ Upload โดยส่งค่าจากตัวแปร file ให้ storageReference
    // เพื่อ putfile ไป firebase
    StorageUploadTask storageUploadTask = storageReference.putFile(file);

    // เมื่อ upload รูปไปแล้วจะขอค่า url Token มาใส่ในตัวแปร _urlImageDaily
    // โดยใช้ await (ในวงเล็บ) สั่งให้คอยคำตอบเมื่อ storageUploadTask status on complete
    // จากนั้นให้ await (นอกวงเล็บ) คอยรับค่า ref จาก method getDownloadURL()
    // ไปใส่ในตัวแปร _urlImageDaily เย้ๆๆ
    _urlImageDaily =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();

    // ทดสอบๆๆๆ
    print('_urlImageDaily = $_urlImageDaily');

    // ส่งค่าต่างๆ ขึ้น firestore (ทั้ง urlimage และข้อความ)
    insertDataToFireStore();
  }

  Future<void> insertDataToFireStore() async {
    Firestore firestore = Firestore.instance;

    // สร้างตัวแปรชนิด map พร้อมแทนค่าเพื่อส่งไป firestore
    Map<String, dynamic> map = Map();
    map['unitImage'] = _unitImage;
    map['dateImage'] = _dateImage;
    map['titleImage'] = _titleImage;
    map['explainImage'] = _explainImage;
    map['urlImageDaily'] = _urlImageDaily;

    // await firestore
    //     .collection('ImageDailyReport')
    //     .document() // ถ้าต้องการให้ UID มีค่าด้วยให้ใส่ค่าเป็น String ในวงเล็บ
    //     .setData(
    //         map) // ส่วนนี้เป็นการเพิ่มข้อมูล ถ้า Update ใช้คำสั่ง .updateData(newValues)
    //     .then((value) {
    //   print('Insert data is success');
    // });

    await firestore
        .collection('DailyReport')
        .document(widget.getPost.toString())
        .collection('DailyImage')
        .document()
        .setData(map)
        .then((value) {
      print('Insert data is success');
    });
  }

  Future<void> chooseDate() async {
    DateTime chooseDateTime = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 5), // จุดเริ่ม
      lastDate: DateTime(DateTime.now().year + 5), // สิ้นสุด
    );

    if (chooseDateTime != null) {
      setState(() {
        dateTime = chooseDateTime;
      });
    }
  }

  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55.0,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            color: Colors.blue,
            onPressed: () {
              print('You click Upload');

              if (file == null) {
                showAlert('ไม่มีรูป', 'กรุณาเพิ่มรูปด้วย กล้อง หรือ อัลบั้ม');
              } else if (_unitImage == null ||
                  _unitImage.isEmpty ) {
                showAlert('ไม่มีข้อมูล', 'กรุณากรอกข้อมูลในช่องว่าง');
              } else {
                // Upload to firebase
                uploadPictureToStorage();

                // กลับหน้าเดิม
                Navigator.of(context).pop();
              }
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Upload Image',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget unitImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 20.0, 4.0, 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 55.0,
        child: TextField(
          onChanged: (String string) {
            _unitImage = string.trim();
            print('_unitImage = $_unitImage');
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.home, size: 28.0),
              labelText: 'Unit*',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ),
      ),
    );
  }

  
  Widget dateImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 55.0,
        child: TextField(
          onTap: () {
            chooseDate();
            print(dateTime);
            _dateImage =
                '${dateTime.day} - ${dateTime.month} - ${dateTime.year}';
          },
          onChanged: (String string) {
            _dateImage = string.trim();
            print('_subtitleImage = $_dateImage');
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.calendar_today, size: 24.0),
              labelText: _dateImage,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ),
      ),
    );
  }


  Widget explainImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 55.0,
        child: TextField(
          onChanged: (String string) {
            _explainImage = string.trim();
            print('_explainImage = $_explainImage');
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.forum, size: 30.0),
              labelText: 'Explian detail',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ),
      ),
    );
  }

  Widget titleImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 55.0,
        child: TextField(
          onChanged: (String string) {
            _titleImage = string.trim();
            print('_titleImage = $_titleImage');
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.mode_comment, size: 24.0),
              labelText: 'title',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ),
      ),
    );
  }

  Widget galloryButton() {
    return IconButton(
      icon: Icon(Icons.add_photo_alternate, size: 40.0, color: Colors.blue),
      onPressed: () {
        chooseImage(ImageSource.gallery);
      },
    );
  }

  Widget cameraButton() {
    return IconButton(
      icon: Icon(Icons.add_a_photo, size: 36.0, color: Colors.blue),
      onPressed: () {
        chooseImage(ImageSource.camera);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        cameraButton(),
        SizedBox(width: 60.0),
        galloryButton(),
        SizedBox(width: 30.0),
      ],
    );
  }

  Widget showImage() {
    return Center(
      child: Container(
        color: Colors.grey[100],
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.4,
        child: file == null
            ? Image.asset('images/imageplaceholder.jpg')
            : Image.file(
                file,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget showContent() {
    return ListView(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text('ID : ${widget.getPost.toString()}',style: TextStyle(color: Colors.grey),),
            showImage(),
            // showButton(),
            unitImage(),
            // dateImage(),
            titleImage(),
            // explainImage(),
            SizedBox(height: 20.0),
            uploadButton(),
            SizedBox(height: 100.0),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image'),
        actions: <Widget>[
          // choose gallory
          CircleAvatar(
            child: IconButton(
              icon: Icon(Icons.add_photo_alternate,
                  color: Colors.white, size: 25.0),
              onPressed: () {
                chooseImage(ImageSource.gallery);
              },
            ),
          ),

          SizedBox(width: 20.0),
          // choose camera
          CircleAvatar(
              child: IconButton(
            icon: Icon(Icons.add_a_photo, color: Colors.white, size: 20.0),
            onPressed: () {
              chooseImage(ImageSource.camera);
            },
          )),

          SizedBox(width: 20.0),
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            showContent(),
          ],
        ),
      ),
    );
  }
}
