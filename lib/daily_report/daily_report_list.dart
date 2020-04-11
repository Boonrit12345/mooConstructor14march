import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mooconstructor14march/daily_report/add_multi_image_upload_firestore.dart';
import 'package:mooconstructor14march/daily_report/crud_daily_report.dart';
import 'package:mooconstructor14march/daily_report/daily_report_detail.dart';

class DailyReportList extends StatefulWidget {
  @override
  _DailyReportListState createState() => _DailyReportListState();
}

class _DailyReportListState extends State<DailyReportList> {
  // Explicit
  String carModel;
  String carColor;

  var cars;
  crudDailyReportMedthods crudObj = new crudDailyReportMedthods();

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

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Data', style: TextStyle(fontSize: 15.0)),
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
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Daily Report'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort, size: 35.0, color: Colors.white),
            onPressed: null,
          ),
          SizedBox(
            width: 15.0,
          ),
          IconButton(
            icon: Icon(Icons.add, size: 35.0),
            onPressed: () {
              addDialog(context);
            },
          ),
          SizedBox(
            width: 15.0,
          ),
          // IconButton(
          //   icon: Icon(Icons.refresh, size: 35.0),
          //   onPressed: () {
          //     crudObj.getData().then((results) {
          //       setState(() {
          //         cars = results;
          //       });
          //     });
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.perm_media, size: 35.0),
            onPressed: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (BuildContext context) {
                return UploadMultipleImage();
              });
              Navigator.of(context).push(route); // กดย้อนกลับได้
            },
          ),
          SizedBox(width: 15.0)
        ],
      ),
      body: _carList(),
    );
  }

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
                return new ListTile(
                  leading: FlutterLogo(size: 50.0),
                  title: Text(snapshot.data.documents[i].data['carName']),
                  subtitle: Text(snapshot.data.documents[i].data['color']),
                  // subtitle: Text(snapshot.data.documents[i].documentID.toString()),
                  trailing: Icon(Icons.more_vert),
                  // isThreeLine: true,
                  onTap: () {
                    // updateDialog(
                    //     context, snapshot.data.documents[i].documentID);

                    MaterialPageRoute route =
                        MaterialPageRoute(builder: (BuildContext context) {
                      return DailyReportDetail();
                    });
                    Navigator.of(context).push(route); // กดย้อนกลับได้
                  },
                  onLongPress: () {
                    crudObj.deleteData(snapshot.data.documents[i].documentID);
                  },
                );
              },
            );
          }
        },
      );
    } else {
      return Text('Loading, Please wait..');
    }
  }

  Widget _imageList() {
    if (cars != null) {
      return StreamBuilder(
        stream: cars,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Container(
              color: Colors.grey,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 400.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, i) {
                  return Container(
                    color: Colors.white,
                    width: 200.0,
                    height: 200.0,
                    child: Card(
                      child: Wrap(
                        children: <Widget>[
                          Image.network(
                              'https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                          ListTile(
                            title: Text(
                                snapshot.data.documents[i].data['carName']),
                            subtitle:
                                Text(snapshot.data.documents[i].data['color']),
                            // trailing: Icon(Icons.more_vert),
                            onTap: () {},
                            onLongPress: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      );
    } else {
      return Text('Loading, Please wait..');
    }
  }

  Widget _imageList2() {
    if (cars != null) {
      return StreamBuilder(
        stream: cars,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return Container(
                  color: Colors.white,
                  width: 220.0,
                  height: 200.0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                'https://images.unsplash.com/photo-1503875154399-95d2b151e3b0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                                width: 220,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                  top: 16,
                                  left: 120,
                                  child: Container(
                                    height: 25,
                                    width: 80,
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
                                        'feature',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                        ),
                        ListTile(
                          title:
                              Text(snapshot.data.documents[i].data['carName']),
                          subtitle:
                              Text(snapshot.data.documents[i].data['color']),
                        ),
                      ]),
                );
              },
            );
          }
        },
      );
    } else {
      return Text('Loading, Please wait..');
    }
  }
}
