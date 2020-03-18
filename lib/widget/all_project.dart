import 'package:flutter/material.dart';
import 'package:mooconstructor14march/utility/my_style.dart';

class MyProjectList extends StatefulWidget {
  @override
  _MyProjectListState createState() => _MyProjectListState();
}

class _MyProjectListState extends State<MyProjectList> {
// Field

// Method

Widget showbuildListView() {
    return ListView.builder(
        itemCount: 15,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text('The list item #$index'),
            subtitle: Text('The subtitle #$index'),
            leading: Icon(
              Icons.check_circle,
              size: 35.0,
              color: MyStyle().primaryColor,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            // เมื่อกดปุ่มนี้
            onTap: null,
          );
        });
  }

  Widget showBody() {
    return Container(
      child: Center(
        child: Text(
          'No Project',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showbuildListView(),
    );
  }
}
