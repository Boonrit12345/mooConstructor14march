import 'package:flutter/material.dart';

class ItcTcrCheckListPage extends StatefulWidget {
  @override
  _ItcTcrCheckListPageState createState() => _ItcTcrCheckListPageState();
}

class _ItcTcrCheckListPageState extends State<ItcTcrCheckListPage> {
  // Explicit

  // Method

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
            Center(
              child: Text(
                'หน้าแสดงหัวกระดาษ',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey), // แทนค่าด้วย Widget ที่เปิดหน้านั้นๆ
              ),
            ),
            Center(
              child: Text(
                'Check list ก่อนก่อสร้าง',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey), // แทนค่าด้วย Widget ที่เปิดหน้านั้นๆ
              ),
            ),
            Center(
              child: Text(
                'Check list ระหว่างก่อสร้าง',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey), // แทนค่าด้วย Widget ที่เปิดหน้านั้นๆ
              ),
            ),
            Center(
              child: Text(
                'Check list หลังก่อสร้าง',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey), // แทนค่าด้วย Widget ที่เปิดหน้านั้นๆ
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.send,
            size: 35.0,
          ),
          label: Text(
            'Submit',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            print('Click Floating action Button');
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
