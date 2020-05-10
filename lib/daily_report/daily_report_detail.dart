import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:mooconstructor14march/daily_report/Features.dart';
// import 'package:mooconstructor14march/daily_report/MainGridList.dart';
import 'package:mooconstructor14march/daily_report/add_daily_image.dart';
import 'package:mooconstructor14march/daily_report/add_multi_image_upload_firestore.dart';
import 'package:mooconstructor14march/daily_report/crud_Picture_daily_report.dart';
// import 'package:mooconstructor14march/daily_report/crud_daily_report.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:mooconstructor14march/daily_report/crud_daily_report.dart';

class DailyReportDetail extends StatefulWidget {
  // Explicit
  final DocumentSnapshot post;

  DailyReportDetail({this.post});

  @override
  _DailyReportDetailState createState() => _DailyReportDetailState();
}

class _DailyReportDetailState extends State<DailyReportDetail> {
  // Explicit
  String carModel;
  String carColor;
  String getPost;

  var cars;
  var dailyProgress;
  var dailyStaff;
  var dailyLabor;
  var dailyMaterial;
  var dailyMachine;

  var thisInstant = new DateTime.now();

  // ข้อมูลรูป
  crudPictureDailyReportMedthods crudObj = new crudPictureDailyReportMedthods();
  // ข้อมูลรายงานประจำวัน
  crudDailyReportMedthods crudObjDailyReport = new crudDailyReportMedthods();

  // function
  navigateToDetail(String _getPost) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddDailyImagePage(
                  getPost: _getPost,
                )));
  }

  // Method

  @override
  void initState() {
    super.initState();
    getPost = widget.post.documentID;
    thisInstant = new DateTime.now();

    // รับข้อมูล รูปถ่ายประจำวัน มาแสดง
    crudObj.getData(widget.post.documentID).then((results) {
      setState(() {
        cars = results;
      });
    });

    // รับข้อมูล รายงานประจำวัน มาแสดง
    crudObjDailyReport
        .getDataDailyProgress(widget.post.documentID)
        .then((results) {
      setState(() {
        dailyProgress = results;
      });
    });

    // รับข้อมูล พนักงาน มาแสดง
    crudObjDailyReport
        .getDataDailyStaff(widget.post.documentID)
        .then((results) {
      setState(() {
        dailyStaff = results;
      });
    });

    // รับข้อมูล แรงงาน มาแสดง
    crudObjDailyReport
        .getDataDailyLabor(widget.post.documentID)
        .then((results) {
      setState(() {
        dailyLabor = results;
      });
    });

    // รับข้อมูล วัสดุ มาแสดง
    crudObjDailyReport
        .getDataDailyMaterial(widget.post.documentID)
        .then((results) {
      setState(() {
        dailyMaterial = results;
      });
    });

    // รับข้อมูล เครื่องจักร มาแสดง
    crudObjDailyReport
        .getDataDailyMachine(widget.post.documentID)
        .then((results) {
      setState(() {
        dailyMachine = results;
      });
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

  Widget showListview() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: 4,
      itemBuilder: (BuildContext context, int childIdx) {
        return Column(
          children: <Widget>[
            Container(
              height: 40.0,
              child: ListTile(
                leading: Text('${childIdx + 1}'),
                title: Text("Child $childIdx"),
                trailing: Text('100'),
              ),
            ),
            Divider(
              thickness: 1.2,
            ),
          ],
        );
      },
    );
  }

  Widget showDailyReportTitleTable() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
              child: Icon(Icons.description, size: 40.0), radius: 40.0),
          title: Text('วันที่ : ${widget.post.data['carName']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('ผู้รายงาน : ${widget.post.data['color']}'),
              Text('ผู้รับทราบ : ${widget.post.data['color']}'),
              // Text('${widget.post.documentID}'),
              Text(getPost),
            ],
          ),
        ),
        Divider(
          thickness: 2.0,
        ),
      ],
    );
  }

  Widget _imageList2() {
    return StreamBuilder(
      stream: cars, // รับข้อมูลแบบ dynamic หรือ map ก็ได้
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            height: (snapshot.data.documents.length > 0) ? 280.0 : 0.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return Container(
                  width: 220.0,
                  height: 220.0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                snapshot
                                    .data.documents[i].data['urlImageDaily'],
                                width: 220,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                  top: 16,
                                  left: 160,
                                  child: Container(
                                    height: 25,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        color:
                                            Colors.black, //Color(0xff0F0F0F),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          )
                                        ]),
                                    child: Center(
                                      child: Text(
                                        (snapshot.data.documents[i]
                                                    .data['unitImage'] !=
                                                null)
                                            ? snapshot.data.documents[i]
                                                .data['unitImage']
                                            : 'n/a',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                        ),
                        ListTile(
                            title: Text((snapshot
                                        .data.documents[i].data['titleImage'] !=
                                    null)
                                ? snapshot.data.documents[i].data['titleImage']
                                : ''),
                            subtitle: Text((snapshot.data.documents[i]
                                        .data['explainImage'] !=
                                    null)
                                ? snapshot
                                    .data.documents[i].data['explainImage']
                                : ''),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  crudObj.deleteData(
                                      snapshot.data.documents[i].documentID);
                                },
                              ),
                            )),
                      ]),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget acceptButton() {
    return Container(
      width: 150.0,
      height: 45.0,
      child: RaisedButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'Accept',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget showTextTitle(String _titleText, String _trailingText,
      double _fontSize, Function onClick) {
    return ListTile(
      title: Text(
        _titleText,
        style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 25.0,
            width: 80.0,
            child: FlatButton(
              onPressed: onClick,
              child: Text(_trailingText),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget showTextSubject(String _txtSubject) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(_txtSubject,
          style: TextStyle(
              fontFamily: 'ConcertOne-Regular',
              fontSize: 18,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget showCoverReport() {
    return Column(
      children: <Widget>[
        Image.asset('images/arch123.jpg'),
      ],
    );
  }

  Widget showPictureHorizontalViewReport() {
    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('รูปถ่ายประจำวัน'),
            Row(
              children: <Widget>[
                Image.asset(
                  'images/arch123.jpg',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.0),
                Image.asset(
                  'images/arch123.jpg',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.0),
                Image.asset(
                  'images/arch123.jpg',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> addDailyProgress(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Daily Progress', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 125.0,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'รายละเอียดงาน :'),
                    onChanged: (value) {
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'ปริมาณงาน :'),
                    onChanged: (value) {
                      this.carColor = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                child: Text('Add'),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    thisInstant = new DateTime.now();
                  });
                  crudObjDailyReport
                      .createDailyProgress(widget.post.documentID, {
                    'items': this.carModel,
                    'actual': this.carColor,
                    'txttime': this.thisInstant,
                  }).then((result) {
                    // dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                child: Text('Cancel'),
                textColor: Colors.blue,
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget showDailyProgress() {
    if (dailyProgress != null) {
      return StreamBuilder(
        stream: dailyProgress, // รับข้อมูลแบบ dynamic หรือ map ก็ได้
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      child: ListTile(
                        leading: Text('${i + 1}'),
                        title: Text(
                            (snapshot.data.documents[i].data['items'] != null)
                                ? snapshot.data.documents[i].data['items']
                                : 'n/a'),
                        trailing: Text(
                            (snapshot.data.documents[i].data['actual'] != null)
                                ? snapshot.data.documents[i].data['actual']
                                : 'n/a'),
                        onLongPress: () {
                          setState(() {
                            crudObjDailyReport.deleteDataDailyProgress(
                                widget.post.documentID,
                                snapshot.data.documents[i].documentID);
                          });
                        },
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            );
          }
        },
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('click add to add data!'),
        ],
      );
    }
  }

  Future<bool> addDailyStaff(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Daily Staff', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 125.0,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'ตำแหน่งพนักงาน :'),
                    onChanged: (value) {
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'จำนวน :'),
                    onChanged: (value) {
                      this.carColor = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                child: Text('Add'),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    thisInstant = new DateTime.now();
                  });
                  crudObjDailyReport.createDailyStaff(widget.post.documentID, {
                    'items': this.carModel,
                    'actual': this.carColor,
                    'txttime': this.thisInstant,
                  }).then((result) {
                    // dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                child: Text('Cancel'),
                textColor: Colors.blue,
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget showDailyStaff() {
    if (dailyStaff != null) {
      return StreamBuilder(
        stream: dailyStaff, // รับข้อมูลแบบ dynamic หรือ map ก็ได้
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      child: ListTile(
                        leading: Text('${i + 1}'),
                        title: Text(
                            (snapshot.data.documents[i].data['items'] != null)
                                ? snapshot.data.documents[i].data['items']
                                : 'n/a'),
                        trailing: Text(
                            (snapshot.data.documents[i].data['actual'] != null)
                                ? snapshot.data.documents[i].data['actual']
                                : 'n/a'),
                        onLongPress: () {},
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            );
          }
        },
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('click add to add data!'),
        ],
      );
    }
  }

  Future<void> createDailyLabor() {
    crudObjDailyReport.createDailyLabor(widget.post.documentID, {
      'carName': 'this.carModel',
      'color': 'this.carColor',
    }).then((result) {
      // dialogTrigger(context);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> createDailyMaterial() {
    crudObjDailyReport.createDailyMaterial(widget.post.documentID, {
      'carName': 'this.carModel',
      'color': 'this.carColor',
    }).then((result) {
      // dialogTrigger(context);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> createDailyMachine() {
    crudObjDailyReport.createDailyMachine(widget.post.documentID, {
      'carName': 'this.carModel',
      'color': 'this.carColor',
    }).then((result) {
      // dialogTrigger(context);
    }).catchError((e) {
      print(e);
    });
  }

  Widget buildListTile(String no, String items, String actual) {
    return Container(
      height: 30.0,
      child: ListTile(
        leading: Text(no, style: TextStyle(fontSize: 14.0)),
        title: Text(items, style: TextStyle(fontSize: 14.0)),
        trailing: Text(actual, style: TextStyle(fontSize: 14.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานประจำวัน'),
        actions: <Widget>[
          CircleAvatar(
            child: Text('${widget.post.data['color']}'),
          ),
          IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {
                print('Click option จ้า');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadMultipleImage()));

                setState(() {
                  thisInstant = DateTime.now();
                  print('thisInstant ===>> $thisInstant');
                });
              }),
          SizedBox(
            width: 5.0,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            showDailyReportTitleTable(),

            showTextTitle('รูปถ่ายประจำวัน', 'add', 18.0,
                () => navigateToDetail(widget.post.documentID)),
            _imageList2(),
            showTextTitle('รายงานความก้าวหน้า', 'add', 18.0,
                () => addDailyProgress(context)),
            // buildListTile('no','item(s)','actual'),
            showDailyProgress(),
            SizedBox(height: 18.0),
            showTextTitle('Staff', 'add', 18.0, () => addDailyStaff(context)),
            // buildListTile('no','staff(s)','actual'),
            showDailyStaff(),
            SizedBox(height: 18.0),
            showTextTitle('แรงงาน', 'add', 18.0, () {}),
            // showListview(),
            SizedBox(height: 18.0),
            showTextTitle('วัสดุ', 'add', 18.0, () {}),
            // showListview(),
            SizedBox(height: 18.0),
            showTextTitle('เครื่องจักร', 'add', 18.0, () {}),
            // showListview(),
            // MainGridList(),
            // SizedBox(height: 50.0),
            // acceptButton(),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
