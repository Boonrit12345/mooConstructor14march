import 'package:flutter/material.dart';

class ItcTcrCheckListPage extends StatefulWidget {
  @override
  _ItcTcrCheckListPageState createState() => _ItcTcrCheckListPageState();
}

class _ItcTcrCheckListPageState extends State<ItcTcrCheckListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // body: Text('Body'),
        // body: TabBarView(children: null),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Create ITC&TCR Form'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Title',
              ),
              Tab(
                text: 'Before',
              ),
              Tab(
                text: 'During',
              ),
              Tab(
                text: 'After',
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}