import 'package:flutter/material.dart';

class Place {
  String imageUrl;
  String name;
  String country;

  Place({this.imageUrl, this.name, this.country});
}

class DefectListPage extends StatefulWidget {
  @override
  _DefectListPageState createState() => _DefectListPageState();
}

class _DefectListPageState extends State<DefectListPage> {
// Explicit

  List wonders = [
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Taj-Mahal.jpg",
        name: "Taj Mahal",
        country: "India"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Christ-the-Redeemer.jpg",
        name: "Christ the Redeemer",
        country: "Brazil"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2016/03/petra-jordan9.jpg",
        name: "Petra",
        country: "Jordan"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Great-Wall-of-China-view.jpg",
        name: "The Great Wall of China",
        country: "China"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/View-of-the-Colosseum.jpg",
        name: "The Colosseum",
        country: "Rome"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Machu-Picchu-around-sunset.jpg",
        name: "Machu Picchu",
        country: "Peru"),
  ];

// Method

// แสดงรูปแบบ listview
  Widget showImageListView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // แสดง Listview Builder
      child: ListView.builder(
        itemCount: wonders.length, // จำนวน  list ใน Listview
        itemBuilder: (context, index) {
          return ListTile(
            // ใส่รูป
            leading: Image.network(wonders[index].imageUrl),
            // ให้ title
            title: Text(
              wonders[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            // ใส subtitle
            subtitle: Text(wonders[index].country),
            // ใส่รูป icon ว่ามีรายละเอียดเพิ่มเติม
            trailing: Icon(Icons.keyboard_arrow_right),
          );
        },
      ),
    );
  }

  Widget showPopUpMenuButton() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.add, size: 35.0),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'one_val',
          child: Container(
            child: ListTile(
              title: Text(
                'Setting',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              leading: Icon(
                Icons.settings,
                size: 30.0,
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'two_val',
          child: Container(
            child: ListTile(
              title: Text(
                'Setting',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              leading: Icon(
                Icons.settings,
                size: 30.0,
              ),
            ),
          ),
        ),

        PopupMenuItem<String>(
          value: 'three_val',
          child: Container(
            child: ListTile(
              title: Text(
                'Setting',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              leading: Icon(
                Icons.settings,
                size: 30.0,
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'four_val',
          child: Container(
            child: ListTile(
              title: Text(
                'Setting',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              leading: Icon(
                Icons.settings,
                size: 30.0,
              ),
            ),
          ),
        ),


      ],
      onSelected: (retVal) {
        print(retVal);
        if (retVal == 'one_val') {
          print('Hey one Here');
        } else if (retVal == 'two_val') {
          print('Hey two Here');
        } else if (retVal == 'three_val') {
          print('Hey three Here');
        } else {
          print('Hey four Here');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // เนื้อหา
      body: showImageListView(),
      // APP BAR จ้า
      appBar: AppBar(
        centerTitle: true,
        title: Text('Defect list'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: Icon(Icons.search, size: 35.0),
          ),
          showPopUpMenuButton(),
        ],
      ),
    );
  }
}
