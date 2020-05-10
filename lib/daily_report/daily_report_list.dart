import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mooconstructor14march/daily_report/add_multi_image_upload_firestore.dart';
import 'package:mooconstructor14march/daily_report/crud_daily_report.dart';
import 'package:mooconstructor14march/daily_report/daily_report_detail.dart';
import 'package:mooconstructor14march/daily_report/detail.dart';

class DailyReportList extends StatefulWidget {
  @override
  _DailyReportListState createState() => _DailyReportListState();
}

class _DailyReportListState extends State<DailyReportList> {
  // Explicit
  String carModel;
  String carColor;
  String appTitle = 'Daily Report';

  var cars;
  crudDailyReportMedthods crudObj = new crudDailyReportMedthods();

  // function
  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DailyReportDetail(
                  post: post,
                )));
  }

// Method

  Widget buildDropdownButton() {
    var letter;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButton<String>(
        value: letter,
        onChanged: (val) => setState(() => letter = val),
        items: [
          DropdownMenuItem<String>(
            value: 'A',
            child: Container(
              color: letter == 'A' ? Colors.black12 : null,
              child: Text('The letter A'),
            ),
          ),
          DropdownMenuItem<String>(
            value: 'B',
            child: Container(
              color: letter == 'B' ? Colors.black12 : null,
              child: Text('The letter B'),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );

// #addDialog
  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Daily Report', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 125.0,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Date :'),
                    onChanged: (value) {
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Reporter :'),
                    onChanged: (value) {
                      this.carColor = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.addData({
                    'carName': this.carModel,
                    'color': this.carColor
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
              FlatButton(
                child: Text('Cancel'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  
                },
              ),
            ],
          );
        });
  }

// #updateDialog
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
                    decoration: InputDecoration(hintText: 'Enter car Name'),
                    onChanged: (value) {
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter car color'),
                    onChanged: (value) {
                      this.carColor = value;
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
                  crudObj.updateData(selectedDoc, {
                    'carName': this.carModel,
                    'color': this.carColor
                  }).then((result) {
                    // dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

// #dialogTrigger
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
    super.initState();
    crudObj.getData().then((results) {
      setState(() {
        cars = results;
        
      });
    });
  }

  Widget _dailyReportList() {
    return StreamBuilder(
      stream: cars,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {
              return Container(
                color: (i % 2 == 0) ? Colors.white : Colors.grey[100],
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 15.0,
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue[300],
                  ),
                  title: Text(snapshot.data.documents[i].data['carName']),
                  subtitle: Text('รายงานโดย: ${snapshot.data.documents[i].data['color']}'),
                  trailing: Icon(
                    Icons.fiber_new,
                    color: Colors.red,
                  ),
                  onTap: () => navigateToDetail(snapshot.data.documents[i]),
                  onLongPress: () {
                    crudObj.deleteData(snapshot.data.documents[i].documentID);
                  },
                ),
              );
              
            },
          );
          
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        // backgroundColor: Color(0xFF007FFF).withOpacity(0.5), // ทำให้ Appbar โปร่งใส
        // centerTitle: true,
        title: Text('Daily Report'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, size: 35.0),
            onPressed: () {
              addDialog(context);
            },
          ),
          SizedBox(width: 15.0),
        ],
      ),
      body: _dailyReportList(),
    );
  }
}
