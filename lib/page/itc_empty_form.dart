import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mooconstructor14march/models/template_model.dart';
import 'package:mooconstructor14march/utility/crud_itc.dart';
import 'package:mooconstructor14march/utility/my_constant.dart';
import 'package:mooconstructor14march/utility/normal_dialog.dart';
import 'package:mooconstructor14march/utility/sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ItcEmptyFormList extends StatefulWidget {
  @override
  _ItcEmptyFormListState createState() => _ItcEmptyFormListState();
}

class _ItcEmptyFormListState extends State<ItcEmptyFormList> {
// Explicit

  List<String> titles = List();
  List<TemplateModel> templateModels = List();
  bool statusSQLite = false;

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
                  TemplateModel model = TemplateModel(carModel, carColor);
                  setState(() {
                    templateModels.add(model);
                  });

                  Navigator.of(context).pop();

                  // crudITCObj.addData({
                  //   'carName': this.carModel,
                  //   // 'color': this.carColor
                  // }).then((result) {
                  //   dialogTrigger(context);
                  // }).catchError((e) {
                  //   print(e);
                  // });
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

    checkSQLite();
  }

  Future<void> checkSQLite() async {
    List<TemplateModel> object = await readSQLite();
    print('amountData ===>> ${object.length}');

    if (object.length != 0) {
      statusSQLite = true;
      setState(() {
        templateModels = object;
      });
    }
  }

  // ดูการ delete ค่าใน SQLite : https://flutter.dev/docs/cookbook/persistence/sqlite
  // และ  https://medium.com/flutter-community/using-sqlite-in-flutter-187c1a82e8b

  Future<List<TemplateModel>> readSQLite() async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), MyConstant().nameDatabase));

    var object = await database.query(MyConstant().nameTABLE);

    return List.generate(object.length, (int index) {
      return TemplateModel(object[index]['CarName'], object[index]['CarColor']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Tamplate'),
        bottom: myForm(),
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
      // body: _carList2(),
      body: templateModels.length == 0
          ? Center(
              child: Text('Please Add title'),
            )
          : showListCheck(context),
    );
  }

  Widget buttonBotton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  print('click save');
                  return saveSQLite(context);
                },
                child: Text('Save Template'),
              ),
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {
                    processPublic(context);
                },
                child: Text('Public Template'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> processPublic(BuildContext context)async{

    crudITCMedthods itcMedthods = crudITCMedthods();
    int i=0;

    for (var model in templateModels) {
      i++;
      Map<String, dynamic> map = model.toMap();
      await itcMedthods.addData(map);
      if (i == templateModels.length) {
        Navigator.of(context).pop();
        
      }
    }
  }

  Future<void> saveSQLite(BuildContext context) async {
    if (statusSQLite) {
      await deleteSQLite();
    }

    SqliteHelper sqliteHelper = SqliteHelper();

    int i = 0;

    for (var model in templateModels) {
      i++;
      await sqliteHelper.insertValueToSQLite(model).then((value) {
        print('Insert SQlite OK at Name ==>> ${model.nameCar}');
        if (i == templateModels.length) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  Future<void> deleteSQLite() async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), MyConstant().nameDatabase));
    await database.rawDelete('DELETE FROM tamplateTABLE');
   
  }

  Widget showListCheck(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: templateModels.length,
          itemBuilder: (BuildContext context, int index) {
            return showResult(index);
          },
        ),
        buttonBotton(context),
      ],
    );
  }

  Widget showResult(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(templateModels[index].nameCar),
          Text(templateModels[index].colorCar),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              print('You click delete index = $index');
              setState(() {
                templateModels.removeAt(index);
              });
            },
          )
        ],
      );

  PreferredSize myForm() {
    return PreferredSize(
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
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
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
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
