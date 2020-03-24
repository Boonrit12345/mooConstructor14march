import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mooconstructor14march/page/itctcrform.dart';

import 'package:mooconstructor14march/utility/crud.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Explicit
  Widget appBarTitle = Text('ITC List');
  Icon actionIcon = Icon(
    Icons.search,
    size: 30.0,
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
// Function

// Method
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
            title: Text('Delete Data ?', style: TextStyle(fontSize: 15.0)),
            content: Text('Please comfirm to delete data!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Delete'),
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
                child: Text('Cancel'),
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
            IconButton(
              icon: Icon(Icons.add, size: 30.0),
              onPressed: () {
                // เพิ่มข้อมูล
                addDialog(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: 30.0,
                ),
                onPressed: () {
                  // Refesh Data
                  crudObj.getData().then((results) {
                    setState(() {
                      cars = results;
                    });
                  });
                },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
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
                        print('snapshot.data.documents[i].documentID =');
                        print(snapshot.data.documents[i].documentID);
                        updateDialog(
                            context, snapshot.data.documents[i].documentID);
                      },
                      onLongPress: () {
                        // จุดๆ นี้ ต้องการการยืนยันก่อนการลบ
                        comfirmDalete(
                            context, snapshot.data.documents[i].documentID);

                        // AlertDialog(
                        //   title: Text('คุณกำลังลบข้อมูล'),
                        //   content: Text('กรุณายืนยันการลบข้อมูล'),
                        //   actions: <Widget>[
                        //     FlatButton(
                        //       onPressed: () {
                        //         Navigator.of(context).pop();
                        //         crudObj.deleteData(
                        //             snapshot.data.documents[i].documentID);
                        //       },
                        //       child: Text('ยืนยัน'),
                        //     ),
                        //     FlatButton(
                        //       onPressed: () {
                        //         Navigator.of(context).pop();
                        //       },
                        //       child: Text('ยกเลิก'),
                        //     )
                        //   ],
                        // );
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
