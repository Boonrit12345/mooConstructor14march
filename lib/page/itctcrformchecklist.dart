import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mooconstructor14march/page/itc_a_page.dart';
import 'package:mooconstructor14march/page/itc_b_page.dart';
import 'package:mooconstructor14march/page/itc_c_page.dart';

import 'package:mooconstructor14march/utility/my_style.dart';

class ItcTcrCheckListPage extends StatefulWidget {

final DocumentSnapshot post;  // สร้าง Object post รับค่าจากการ route มาจาก page อื่น
ItcTcrCheckListPage({this.post}); // รับค่า Object จาก parameter DocumentSnapshot

  @override
  _ItcTcrCheckListPageState createState() => _ItcTcrCheckListPageState();
}

class _ItcTcrCheckListPageState extends State<ItcTcrCheckListPage> {
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

Widget itcTitleWidget(){
  return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            
            showText('โครงการ'),
            showTextDetail(widget.post.data['Project']),
            showTextDetail(widget.post.data['ITC_No']),
            showText('ลักษณะงาน'),
            showTextDetail(widget.post.data['JobType']),
            showTextDetail(widget.post.data['JobName']),
            showText('Location'),
            showTextDetail(widget.post.data['Location']),
            showTextDetail(widget.post.data['GridLine']),
            showText('Date - Time'),
            showTextDetail(widget.post.data['Date']),
            showTextDetail(widget.post.data['PlanDate']),
            showTextDetail(widget.post.data['ActualDate']),
            showText('Submit by'),
            showTextDetail('ผู้รับเหมา'),
            showText('Submit to'),
            showTextDetail('ผู้อนุมัติ'),
          ],
        ),
      ),
    );
}



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // body: Text('Body'),
        // body: TabBarView(children: null),
        appBar: AppBar(
          centerTitle: true,
          title: Text('ITC&TCR Check'),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.check_circle,
                  size: 30.0,
                  color: Colors.greenAccent,
                ),
                text: 'หัวเรื่อง',
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle,
                  size: 30.0,
                  color: Colors.greenAccent,
                ),
                text: 'A.ก่อนก่อสร้าง',
              ),
              Tab(
                icon: Icon(
                  Icons.error,
                  color: Colors.redAccent,
                  size: 30.0,
                ),
                text: 'B.ระหว่างก่อสร้าง',
              ),
              Tab(
                icon: Icon(
                  Icons.radio_button_unchecked,
                  size: 30.0,
                ),
                text: 'C.หลังก่อสร้าง',
              ),
            ],
          ),
          actions: <Widget>[],
        ),
        body: TabBarView(
          children: <Widget>[
            // ส่วนต่อไปนี้ สามารถเรียกใช้หน้า page ได้เลย เรียงตาม Tab
            itcTitleWidget(), // Widget in this page
            ItcAPage(),
            ItcBPage(),
            ItcCPage(),
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   icon: Icon(
        //     Icons.send,
        //     size: 35.0,
        //   ),
        //   label: Text(
        //     'Submit',
        //     style: TextStyle(
        //       fontSize: 20.0,
        //     ),
        //   ),
        //   onPressed: () {
        //     print('Click Floating action Button');
        //     Navigator.of(context).pop();
        //   },
        // ),
      ),
    );
  }
}
