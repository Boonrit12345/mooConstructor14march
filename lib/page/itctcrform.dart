import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:mooconstructor14march/utility/crud.dart';
import 'package:mooconstructor14march/utility/my_style.dart';
import 'package:intl/intl.dart';

// ===============================================
class ItcTcrForm extends StatefulWidget {
  @override
  _ItcTcrFormState createState() => _ItcTcrFormState();
}

class _ItcTcrFormState extends State<ItcTcrForm> {
  // Explicit
  // final DocumentSnapshot post; // สร้าง Object post

  // ItcTcrForm({this.post}); // รับค่า Object จาก parameter DocumentSnapshot

  String itcProject; // ชื่อโครงการ
  String itcITCNo; // ITC No
  String itcJobType; // ประเภทงาน (โครงสร้าง, สถาปัตยกรรม, งานระบบ)
  String itcJobName; // ชื่องาน
  String itcLocation; // บริเวณ
  String itcGridLine; // กริดไลน์
  String itcDate; // วันที่ส่งเอกสาร
  String itcPlanDate; // วันที่ตามแผนงาน
  String itcActualDate; // วันที่ทำจริง
  crudMedthods crudObj = new crudMedthods();

  String value = "";
  DateTime selectedDate = DateTime.now();
  var customFormat = DateFormat('dd-MM-yyyy');

  final elements1 = [
    "Breakfast",
    "Lunch",
    "2nd Snack",
    "Dinner",
    "3rd Snack",
  ];
  final elements2 = [
    "Cheese Steak",
    "Chicken",
    "Salad",
  ];

  final elements3 = [
    "7am - 10am",
    "11am - 2pm",
    "3pm - 6pm",
    "7pm-10pm",
  ];

  final elements4 = [
    "Lose fat",
    "Gain muscle",
    "Keep in weight",
  ];

  int selectedIndex1 = 0,
      selectedIndex2 = 0,
      selectedIndex3 = 0,
      selectedIndex4 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  List<Widget> _buildItems2() {
    return elements2
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  List<Widget> _buildItems3() {
    return elements3
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  List<Widget> _buildItems4() {
    return elements4
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

// ส่วนของ DropDownMenu ========================================================
  List _fruits = [
    "South Bangkok Power Plant",
    "ศูนย์การค้าเซ็นทรัลจักรวาล",
    "ปรับปรุงจีทาวเวอร์",
    "อาคารสำนักงาน",
    "สนามกีฬา"
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedFruit;

  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_fruits);
    _selectedFruit = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedFruit = selectedFruit;
    });
  }
  // ===================================================================

  // Method

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

  // DatePicker PART
  Future<Null> showPicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget showTextAndDatePicker() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${customFormat.format(selectedDate)}',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => showPicker(context),
              child: Text('Click Here To Select Date'),
              textColor: Colors.white,
              color: Colors.blue,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget showDropDownMenu() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
      child: Container(
        color: Colors.grey[100],
        width: 300.0,
        height: 60.0,
        // decoration: ShapeDecoration(
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(10.0))),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _selectedFruit,
              items: _dropDownMenuItems,
              // hint: Text('data'),
              onChanged: changedDropDownItem,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  Widget showDirectSelect() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "To which meal?",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ),
        DirectSelect(
            itemExtent: 35.0,
            selectedIndex: selectedIndex1,
            child: MySelectionItem(
              isForList: false,
              title: elements1[selectedIndex1],
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedIndex1 = index;
              });
            },
            items: _buildItems1()),
      ],
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.message,
            color: MyStyle().darkColor,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 5.0),
            child: Text(
              text,
              style: TextStyle(
                color: MyStyle().darkColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showTextPink(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.message,
            color: Colors.pinkAccent,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 5.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showTextFromFillDatePicker(String textfill) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            onTap: () {
              print("I'm here!!!");
              showPicker(context);
            },
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.date_range),
                labelText: textfill,
                // prefixText: 'ITC No.',
                // hintText: 'ITC No. ',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }

  Widget showTextFromFill(String textfill) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            onTap: null,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.cancel),
                labelText: textfill,
                labelStyle: TextStyle(
                  color: MyStyle().darkColor,
                  fontSize: 18.0,
                ),
                // prefixText: 'ITC No.',
                // hintText: 'ITC No. ',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }

  Widget showTextFromFillPink(String textfill) {
    return Container(
      color: Colors.pink[50],
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            onTap: null,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.cancel,
                  color: Colors.pink[600],
                ),
                labelText: textfill,
                labelStyle: TextStyle(
                  color: Colors.pink[900],
                  fontSize: 18.0,
                ),
                // prefixText: 'ITC No.',
                // hintText: 'ITC No. ',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            showText('โครงการ'),

            // add #1 - itcProject ; // ชื่อโครงการ
            TextField(
              decoration: InputDecoration(
                  hintText: 'โครงการ',
                  suffixIcon:
                      IconButton(icon: Icon(Icons.cancel), onPressed: null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                this.itcProject = value;
              },
            ),
            SizedBox(height: 15.0),

            // showTextFromFill('โครงการ : '),
            // showText('กรุณากรอกแบบฟอร์ม'),
            // showDropDownMenu(),
            // showTextFromFill('ITC No.: '),

            // add #2 - itcITCNo ; // ITC No
            TextField(
              decoration: InputDecoration(
                  hintText: 'ITC No.',
                  suffixIcon:
                      IconButton(icon: Icon(Icons.cancel), onPressed: null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                this.itcITCNo = value;
              },
            ),
            SizedBox(height: 15.0),
            //

            showText('รายละเอียดงาน'),
            // showTextFromFill('ประเภทงาน : '),

            // add #3 - itcJobType ; // ประเภทงาน(โครงสร้าง,สถาปัตยฯ,งานระบบ)
            TextField(
              decoration: InputDecoration(
                  hintText: 'ประเภทงาน(โครงสร้าง,สถาปัตยฯ,งานระบบ)',
                  suffixIcon:
                      IconButton(icon: Icon(Icons.cancel), onPressed: null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                this.itcJobType = value;
              },
            ),
            SizedBox(height: 15.0),
            //
            // showTextFromFill('หมวดงาน : '),

            // add #4 - itcJobName ; // ชื่องาน
            TextField(
              decoration: InputDecoration(
                  hintText: 'ชื่องาน',
                  suffixIcon:
                      IconButton(icon: Icon(Icons.cancel), onPressed: null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                this.itcJobName = value;
              },
            ),
            SizedBox(height: 15.0),

            //
            showText('Location'),
            // showTextFromFill('บริเวณ : '),
            // add #5 - itcLocation ; // บริเวณ
            TextField(
              decoration: InputDecoration(
                  hintText: 'Location',
                  suffixIcon:
                      IconButton(icon: Icon(Icons.cancel), onPressed: null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                this.itcLocation = value;
              },
            ),
            SizedBox(height: 15.0),

            // showTextFromFill('Grid Line : '),
            // add #6 - itcGridLine ; // กริดไลน์
            TextField(
              decoration: InputDecoration(
                  hintText: 'Grid Line',
                  suffixIcon:
                      IconButton(icon: Icon(Icons.cancel), onPressed: null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                this.itcGridLine = value;
              },
            ),
            SizedBox(height: 15.0),

            //
            showText('Date - Time'),
            // showTextFromFillDatePicker('${customFormat.format(selectedDate)}'), // ลงวันที่วันนี้
            // add #7 - itcDate ; // วันที่ส่งเอกสาร
            TextField(
              decoration: InputDecoration(
                  hintText: 'Date',
                  suffixIcon:
                      IconButton(icon: Icon(Icons.cancel), onPressed: null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                this.itcDate = value;
              },
            ),
            SizedBox(height: 15.0),

            // showTextFromFillDatePicker('Plan Date : '),
            // add #8 - itcPlanDate ; // วันที่ตามแผนงาน
            TextField(
              decoration: InputDecoration(
                  hintText: 'Plan Date',
                  suffixIcon:
                      IconButton(icon: Icon(Icons.cancel), onPressed: null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                this.itcPlanDate = value;
              },
            ),
            SizedBox(height: 15.0),

            // showTextFromFillDatePicker('Actual Date : '),
            // add #9 - itcActualDate ; // วันที่ทำจริง
            TextField(
              decoration: InputDecoration(
                  hintText: 'Actual Date',
                  suffixIcon:
                      IconButton(icon: Icon(Icons.cancel), onPressed: null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                this.itcActualDate = value;
              },
            ),
            SizedBox(height: 15.0),

            showTextPink('Submit to :'),
            showTextFromFillPink('Submit to'),
            //
            // Submit Button ======================>>
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 25.0, 8.0, 8.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    crudObj.addData({
                      // ใส่ข้อมูลใน column ชื่อ column เราตั้งจากตรงนี้ได้เลย
                      'Project': this.itcProject,
                      'ITC_No': this.itcITCNo,
                      'JobType': this.itcJobType,
                      'JobName': this.itcJobName,
                      'Location': this.itcLocation,
                      'GridLine': this.itcGridLine,
                      'Date': this.itcDate,
                      'PlanDate': this.itcPlanDate,
                      'ActualDate': this.itcActualDate,
                    }).then((result) {
                      dialogTrigger(context);
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  disabledColor: Colors.blue[50],
                ),
              ),
            ),

            //
          ],
          padding: EdgeInsets.only(bottom: 200.0),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create form : ITC & TCR'),
        actions: <Widget>[
          // PopupMenuButton<String>(
          //   onSelected: null,
          //   itemBuilder: (BuildContext contexts){
          //     return Constants.ch
          //   }),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.save,size: 35.0,),
      //   onPressed: (){
      //     print('Click Floating action Button');
      //   },
      // ),

      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.save,
          size: 35.0,
        ),
        label: Text(
          'SAVE',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onPressed: () {
          print('Click Floating action Button');
          Navigator.of(context).pop();
          crudObj.addData({
            // ใส่ข้อมูลใน column ชื่อ column เราตั้งจากตรงนี้ได้เลย
            'Project': this.itcProject,
            'ITC_No': this.itcITCNo,
            'JobType': this.itcJobType,
            'JobName': this.itcJobName,
            'Location': this.itcLocation,
            'GridLine': this.itcGridLine,
            'Date': this.itcDate,
            'PlanDate': this.itcPlanDate,
            'ActualDate': this.itcActualDate,
          }).then((result) {
            dialogTrigger(context);
          }).catchError((e) {
            print(e);
          });
        },
      ),
    );
  }
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
