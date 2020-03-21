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
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.filter_none,
                ),
                text: 'info',
              ),
              Tab(
                icon: Icon(
                  Icons.filter_1,
                ),
                text: 'A.ก่อน',
              ),
              Tab(
                icon: Icon(
                  Icons.filter_2,
                ),
                text: 'B.ระหว่าง',
              ),
              Tab(
                icon: Icon(
                  Icons.filter_3,
                ),
                text: 'C.หลัง',
              ),
            ],
          ),
          actions: <Widget>[],
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text(
                'Title Page',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey), // แทนค่าด้วย Widget ที่เปิดหน้านั้นๆ
              ),
            ),
            Center(
              child: Text(
                'Before Page',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey), // แทนค่าด้วย Widget ที่เปิดหน้านั้นๆ
              ),
            ),
            Center(
              child: Text(
                'During Page',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey), // แทนค่าด้วย Widget ที่เปิดหน้านั้นๆ
              ),
            ),
            Center(
              child: Text(
                'After Page',
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
          },
        ),
      ),
    );
  }
}
