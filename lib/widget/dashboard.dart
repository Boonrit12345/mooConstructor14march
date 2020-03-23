import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mooconstructor14march/utility/crud.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Explicit
  String carModel;
  String carColor;

  // QuerySnapshot cars;
  var cars;

  crudMedthods crudObj = new crudMedthods();
// Function
  void testTest() {
    print('Test  ..  Test  ..  Test  ..  Test  ..  Test  ..  ');
    // AlertDialog(
    //   title: const Text('Please COnfirm?'),
    //   content: const Text('Do you delete data?'),
    //   actions: <Widget>[
    //     FlatButton(
    //       onPressed: null,
    //       child: const Text('Cancel'),
    //     ),
    //     FlatButton(
    //       onPressed: null,
    //       child: const Text('OK'),
    //     )
    //   ],
    // );
  }

  // enum ConfirmAction { CANCEL, ACCEPT }

Future<bool> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reset settings?'),
        content: const Text(
            'This will reset your device to its default factory settings.'),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

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
    return new Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text('ITC LIST'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 35.0,
              ),
              onPressed: () {
                addDialog(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: 35.0,
                ),
                onPressed: () {
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
                      title: Text(snapshot.data.documents[i].data['carName']),
                      subtitle: Text(snapshot.data.documents[i].data['color']),
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
                        updateDialog(
                            context, snapshot.data.documents[i].documentID);
                      },
                      onLongPress: () {
                        // 
                        crudObj
                            .deleteData(snapshot.data.documents[i].documentID);
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
      return Center(child: Text('Loading, Please wait..'));
    }
  }
}
