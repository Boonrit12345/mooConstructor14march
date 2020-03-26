import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mooconstructor14march/utility/my_style.dart';

class ItcTitlePage extends StatefulWidget {

// final DocumentSnapshot post;  // สร้าง Object post รับค่าจากการ route มาจาก page อื่น
// ItcTitlePage({this.post}); // รับค่า Object จาก parameter DocumentSnapshot


  @override
  _ItcTitlePageState createState() => _ItcTitlePageState();
}

class _ItcTitlePageState extends State<ItcTitlePage> {
  // Explicit

  // Method

  Widget showTextDetail(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.edit,
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
          Divider(
            height: 2.0,
            thickness: 1.0,
          ),
        ],
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Icon(
          //   Icons.message,
          //   color: MyStyle().darkColor,
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 5.0),
            child: Text(
              text,
              style: TextStyle(
                color: MyStyle().darkColor,
                fontSize: 18.0,
                // fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
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
            showTextDetail('WIZE DOM 101 Sukumvit101'),
            showTextDetail('ITC/DEMO/001/2563'),
            showText('ลักษณะงาน'),
            showTextDetail('งานสถาปัตยกรรม'),
            showTextDetail('งานก่ออิฐมวลเบา'),
            showText('Location'),
            showTextDetail('บริเวณ'),
            showTextDetail('Grid Line'),
            showText('Date - Time'),
            showTextDetail('Date'),
            showTextDetail('Plan Date'),
            showTextDetail('Actual Date'),
            showText('Submit by'),
            showTextDetail('ผู้รับเหมา'),
            showText('Submit to'),
            showTextDetail('ผู้อนุมัติ'),
          ],
        ),
      ),
    );
  }
}
