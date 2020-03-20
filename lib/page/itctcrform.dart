import 'package:flutter/material.dart';
import 'package:mooconstructor14march/utility/my_style.dart';

// ===============================================
class ItcTcrForm extends StatefulWidget {
  @override
  _ItcTcrFormState createState() => _ItcTcrFormState();
}

class _ItcTcrFormState extends State<ItcTcrForm> {
  // Explicit
  var _currencies = ['one', 'two', 'three'];
  // Method

  Widget showTextFromFill(String textfill) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            style: TextStyle(),
            decoration: InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.create,
                    color: MyStyle().darkColor,
                  ),
                  Text(
                    'กรุณากรอกแบบฟอร์ม เพื่อเปิดเอกสาร',
                    style: TextStyle(
                      color: MyStyle().darkColor,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            
            showTextFromFill('ITC No.: '),
            showTextFromFill('Project : '),
            showTextFromFill('Subject : '),
            showTextFromFill('ประเภทงาน : '),
            showTextFromFill('Location : '),
            showTextFromFill('Grid Line : '),
            showTextFromFill('Date : '),
            showTextFromFill('Plan Date : '),
            showTextFromFill('Actual Date : '),
            showTextFromFill('ไฟล์แนบ : '),
            //
          ],
          padding: EdgeInsets.only(bottom: 200.0),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create ITC&TCR Form'),
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
        },
      ),
    );
  }
}
