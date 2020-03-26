import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mooconstructor14march/page/itctcrform.dart';
import 'package:mooconstructor14march/page/itctcrformchecklist.dart';
// import 'package:mooconstructor14march/utility/custom_dialog.dart';

import 'package:mooconstructor14march/utility/crud.dart';
import 'package:mooconstructor14march/utility/custom_dialog_red.dart';

class TimeValue {
  final int _key;
  final String _value;
  TimeValue(this._key, this._value);
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Explicit
  Widget appBarTitle = Text('ITC List');
  Icon actionIcon = Icon(
    Icons.search,
    size: 35.0,
    color: Colors.white,
  );

  String itcProject; // ชื่อโครงการ
  String itcITCNo; // ITC No
  String itcJobType; // ประเภทงาน (โครงสร้าง, สถาปัตยกรรม, งานระบบ)
  String itcJobName; // ชื่องาน
  String itcLocation; // บริเวณ
  String itcGridLine; // กริดไลน์
  String itcDate; // วันที่ส่งเอกสาร
  String itcPlanDate; // วันที่ตามแผนงาน
  String itcActualDate; // วันที่ทำจริง

  // QuerySnapshot cars;
  var cars;

  crudMedthods crudObj = new crudMedthods();

  int _currentTimeValue = 1;

  final _buttonOptions = [
    TimeValue(1, "30 minutes"),
    TimeValue(2, "1 hour"),
    TimeValue(3, "2 hours"),
    TimeValue(4, "4 hours"),
    TimeValue(5, "8 hours"),
    TimeValue(6, "12 hours"),
  ];

// Function

// Method

// Fantacy AlertDialog and test on LongPress in ListView
  void showCustomDialogWithImage(BuildContext context) {
    Dialog dialogWithImage = Dialog(
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Text(
                "Dialog With Image",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 200,
              width: 300,
              child: Image.asset(
                'images/boss-icon.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel!',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }

//  เรียกใช้ในส่วน LongPress on Listview
  Widget costumAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: _buttonOptions
            .map((timeValue) => RadioListTile(
                  groupValue: _currentTimeValue,
                  title: Text(timeValue._value),
                  value: timeValue._key,
                  onChanged: (val) {
                    setState(() {
                      debugPrint('VAL = $val');
                      _currentTimeValue = val;
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

// สร้าง AlertDialog แบบมี listview ให้เลือก
// ต่อไปเราจะสร้างตัวรับค่า enumlist จาก firebase มาแทนค่า
  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Gujarat, India'),
          );
        },
      ),
    );
  }

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Data', style: TextStyle(fontSize: 15.0)),
            content: Column(
              children: <Widget>[
                // add #1
                TextField(
                  decoration: InputDecoration(
                    hintText: 'ประเภทงาน',
                    suffixIcon:
                        IconButton(icon: Icon(Icons.cancel), onPressed: null),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (value) {
                    this.itcProject = value;
                  },
                ),
                SizedBox(height: 15.0),

                // add #2
                TextField(
                  decoration: InputDecoration(
                    hintText: 'ITC no.',
                    suffixIcon:
                        IconButton(icon: Icon(Icons.cancel), onPressed: null),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (value) {
                    this.itcITCNo = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.addData({
                    // ใส่ข้อมูลใน column ชื่อ column เราตั้งจากตรงนี้ได้เลย
                    'Project': this.itcProject,
                    'ITC_No': this.itcITCNo
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  Future<bool> updateDialog(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Data', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 125.0,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'ประเภทงาน'),
                    onChanged: (value) {
                      this.itcProject = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'ITC no.'),
                    onChanged: (value) {
                      this.itcITCNo = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();

                  // จุดๆ มีการ Update ข้อมูล
                  crudObj.updateData(selectedDoc, {
                    'Project': this.itcProject,
                    'ITC_No': this.itcITCNo
                  }).then((result) {
                    // dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  Future<bool> comfirmDalete(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('คุณกำลังจะลบข้อมูล ?',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent)),
            content: Text(
              'กรุณายืนยัน !',
              style: TextStyle(color: Colors.redAccent),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ลบ',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent)),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();

                  // จุดๆ นี้ มีการลบข้อมูล
                  crudObj.deleteData(selectedDoc);
                },
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('    ยกเลิก',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent)),
              )
            ],
          );
        });
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Job Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        cars = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = Icon(Icons.close);
                    this.appBarTitle = TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    );
                  } else {
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle = Text('ITC List');
                  }
                });
              },
            ),
            // IconButton(
            //   icon: Icon(Icons.add, size: 30.0),
            //   onPressed: () {
            //     // เพิ่มข้อมูล
            //     addDialog(context);
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),

              // Refesh Button
              // child: IconButton(
              //   icon: Icon(
              //     Icons.refresh,
              //     size: 30.0,
              //   ),
              //   onPressed: () {
              //     // Refesh Data
              //     crudObj.getData().then((results) {
              //       setState(() {
              //         cars = results;
              //       });
              //     });
              //   },
              // ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'เพิ่มเอกสาร ITC',
          child: Icon(
            Icons.add,
            size: 35.0,
          ),
          onPressed: () {
            print('Click Floating action Button');
            //
            // Goto page ITC & TCR Form
            MaterialPageRoute route =
                MaterialPageRoute(builder: (BuildContext context) {
              return ItcTcrForm(); // =====>>>> ITC Form สำหรับเพิ่มข้อมูล
            });
            //
            // กดย้อนกลับได้
            Navigator.of(context).push(route);
            //
            //
          },
        ),
        // ให้ปุ่มลอยอยู่กลางหน้า
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _carList());
  }

  // Widget _carList() {
  //   if (cars != null) {
  //     return ListView.builder(
  //       itemCount: cars.documents.length,
  //       padding: EdgeInsets.all(5.0),
  //       itemBuilder: (context, i) {
  //         return new ListTile(
  //           title: Text(cars.documents[i].data['carName']),
  //           subtitle: Text(cars.documents[i].data['color']),
  //         );
  //       },
  //     );
  //   } else {
  //     return Center(child: Text('Loading, Please wait..'));
  //   }
  // }

  Widget _carList() {
    if (cars != null) {
      return StreamBuilder(
        stream: cars,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return Column(
                  children: <Widget>[
                    new ListTile(
                      title: Text(
                        snapshot.data.documents[i].data['Project'],
                        style: TextStyle(fontSize: 17.0),
                      ),
                      subtitle: Text(snapshot.data.documents[i].data['ITC_No']),
                      // subtitle: Text(snapshot.data.documents[i].documentID),
                      trailing: Chip(
                        label: Text(
                          'new',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.blue[50],
                        child: Icon(
                          Icons.mail,
                          size: 35.0,
                        ),
                      ),
                      // trailing: ,
                      onTap: () {
                        // จุดนี้ต้องการ ดึงค่าไปใส่ textField ก่อนแล้วแก้ไขข้อความเดิม
                            // print('snapshot.data.documents[i].documentID =');
                            // print(snapshot.data.documents[i].documentID);
                            // updateDialog(
                            //     context, snapshot.data.documents[i].documentID);

                        // route ===>>> ITC TCR FORM CHECKLIST
                        print('Click ITC & TCR LIST');
                        //
                        // Goto page ITC & TCR Form
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ItcTcrCheckListPage(post: snapshot.data.documents[i]);
                           // =====>>>> ITC & TCR CHECK LIST
                        });
                        //
                        // กดย้อนกลับได้
                        Navigator.of(context).push(route);
                        //
                        //
                      },
                      onLongPress: () {
                        // ทดลอง Dialog สวยๆ
                        //     showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) => CustomDialogRed(
                        //     title: "Would you like to delete an ITC document ?",
                        //     description:
                        //         "With an account, your data will be securely saved, allowing you to access it from multiple devices.",
                        //     primaryButtonText: "Confirm to delete",
                        //     primaryButtonRoute: "", // "/signUp"
                        //     secondaryButtonText: "Maybe Later",
                        //     secondaryButtonRoute: "", // "/home"
                        //   ),
                        // );
                        // จุดๆ นี้ ต้องการการยืนยันก่อนการลบ (ใส่แล้ว ชื่อ confirmDalete())
                        comfirmDalete(
                            context, snapshot.data.documents[i].documentID);

                        // ส่วนนี้ทำให้โชว์ Dialog มาให้เลือกแล้ว
                        // นำไปประยุกต์ ในการเลือกข้อมูลแบบ enum ได้
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AlertDialog(
                        //         title: Text('Country List'),
                        //         content: costumAlertDialoadContainer(),

                        //         // actions: <Widget>[],
                        //       );
                        //     });
                        //จบ showDialog
                      },
                    ),
                    Divider(color: Colors.grey),
                  ],
                );
              },
            );
          }
        },
      );
    } else {
      // return Text('Loading, Please wait..');  /// Error
    }
  }
}
