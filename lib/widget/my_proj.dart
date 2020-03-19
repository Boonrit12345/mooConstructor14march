import 'package:flutter/material.dart';
import 'package:mooconstructor14march/utility/my_style.dart';

class MyProjList extends StatefulWidget {
  @override
  _MyProjListState createState() => _MyProjListState();
}

class _MyProjListState extends State<MyProjList> {

// Explicit


// Method
Widget showDetailInListView1() {
    return Container(
      width: 8.0,
      height: 280.0,
      child: Image.asset('images/projectdemo1.jpg'),
    );
  }

  Widget showDetailInListView2() {
    return Container(
      width: 8.0,
      height: 280.0,
      child: Image.asset('images/projectdemo2.jpg'),
    );
  }

    Widget showDetailInListView3() {
    return Container(
      width: 8.0,
      height: 280.0,
      child: Image.asset('images/projectdemo3.jpg'),
    );
  }

  Widget showDetailInListView() {
    return Container(
      width: 8.0,
      height: 280.0,
      child: Image.asset('images/empryproject.png'),
    );
  }

  Widget showBodyListView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Project demo 1',
              style: TextStyle(
                color: MyStyle().primaryColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'data',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            showDetailInListView1(),
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Project demo 2',
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'data',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            showDetailInListView2(),
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Project demo 3',
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'data',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            showDetailInListView3(),
                        SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
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
      body: showBodyListView(),
    );
  }
}