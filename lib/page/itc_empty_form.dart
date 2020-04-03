import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mooconstructor14march/utility/crud_itc.dart';

class ItcEmptyFormList extends StatefulWidget {
  @override
  _ItcEmptyFormListState createState() => _ItcEmptyFormListState();
}

class _ItcEmptyFormListState extends State<ItcEmptyFormList> {
// Explicit
  String carModel;
  String carColor;

  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();

  // CLear text in Textfield
  clearTextInput1() {
    _controller1.clear();
  }

  // CLear text in Textfield
  clearTextInput2() {
    _controller2.clear();
  }

  // CLear text in Textfield
  clearTextInput3() {
    _controller3.clear();
  }

  var cars;

  crudITCMedthods crudITCObj = new crudITCMedthods();

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
                  // TextField(
                  //   decoration: InputDecoration(hintText: 'Enter car color'),
                  //   onChanged: (value) {
                  //     this.carColor = value;
                  //   },
                  // ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudITCObj.addData({
                    'carName': this.carModel,
                    // 'color': this.carColor
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
                  // TextField(
                  //   decoration: InputDecoration(hintText: 'Enter car color'),
                  //   onChanged: (value) {
                  //     this.carColor = value;
                  //   },
                  // ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudITCObj.updateData(selectedDoc, {
                    'carName': this.carModel,
                    // 'color': this.carColor
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
    crudITCObj.getData().then((results) {
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
        title: Text('Create Tamplate'),
        bottom: PreferredSize(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                  child: TextField(
                    autofocus: false,
                    controller: _controller1,
                    cursorColor: Colors.white,
                    style: TextStyle(
                        color: Colors.white), // ทำให้ข้อความที่กรอก มีสีตามนี้
                    decoration: InputDecoration(
                        fillColor: Colors.blue[400],
                        filled: true,
                        // focusedBorder: InputBorder.none,
                        hintText: 'Form ID',
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(32.0)),
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.filter_center_focus,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          onPressed: null,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                          onPressed: clearTextInput1,
                        )),

                    onChanged: (text) => print(_controller1.text),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    controller: _controller2,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    // controller: searchController,
                    decoration: InputDecoration(
                      fillColor: Colors.blue[400],
                      filled: true,
                      hintText: 'Form Name',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(32.0)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        onPressed: clearTextInput2,
                      ),
                    ),
                    onChanged: (text) => print(_controller2.text),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: TextField(
                    controller: _controller3,
                    cursorColor: Colors.white,

                    style: TextStyle(
                        color: Colors.white), // ทำให้ข้อความที่กรอก มีสีตามนี้
                    decoration: InputDecoration(
                      fillColor: Colors.blue[400],
                      filled: true,
                      hintText: 'Form Type',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(32.0)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        onPressed: clearTextInput3,
                      ),
                    ),
                    onChanged: (text) => print(_controller3.text),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size(50, 200),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              addDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              crudITCObj.getData().then((results) {
                setState(() {
                  cars = results;
                });
              });
            },
          )
        ],
      ),
      body: _carList2(),
    );
  }

  Widget showChipChoice() {
    String _defaultChoiceNo8;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ผ่าน'),
            selected: _defaultChoiceNo8 == 'ผ่าน',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo8 = selected ? 'ผ่าน' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('แก้ไข'),
            selected: _defaultChoiceNo8 == 'แก้ไข',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo8 = selected ? 'แก้ไข' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่ผ่าน'),
            selected: _defaultChoiceNo8 == 'ไม่ผ่าน',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo8 = selected ? 'ไม่ผ่าน' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo8 == 'ไม่มี',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo8 = selected ? 'ไม่มี' : null;
                print('Select ไม่มี');
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _carList2() {
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
                  title: Text(
                    snapshot.data.documents[i].data['carName'],
                    style: TextStyle(fontSize: 18.0),
                  ),
                  // subtitle: Text(snapshot.data.documents[i].data['color']),
                  subtitle: showChipChoice(),
                  // leading: Icon(Icons.arrow_forward),
                  onTap: () {
                    updateDialog(
                        context, snapshot.data.documents[i].documentID);
                  },
                  onLongPress: () {
                    crudITCObj
                        .deleteData(snapshot.data.documents[i].documentID);
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
}
