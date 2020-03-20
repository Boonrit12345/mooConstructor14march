import 'package:flutter/material.dart';
import 'package:mooconstructor14march/page/itctcrform.dart';
import 'package:mooconstructor14march/utility/my_style.dart';

class ItcTcrListPage extends StatefulWidget {
  @override
  _ItcTcrListPageState createState() => _ItcTcrListPageState();
}

class _ItcTcrListPageState extends State<ItcTcrListPage> {
  // Explicit

  // Method

  Widget showListView() {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text('งานผนังก่ออิฐมวลเบา #$index'),
            subtitle: Text('ITC No. :ITC/WD4/00$index/2563'),
            leading: Icon(
              Icons.check_circle_outline,
              size: 35.0,
              color: MyStyle().darkColor,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            // เมื่อกดปุ่มนี้
            onTap: () {
              print('Click ');
              //
              // Goto page ITC & TCR Form
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (BuildContext context) {
                return ItcTcrForm(); // =====>>>> ITC & TCR Form
              });
              //
              // กดย้อนกลับได้
              Navigator.of(context).push(route);
              //
              //
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // เนื้อหา
      body: showListView(),
      // APP BAR จ้า
      appBar: AppBar(
        centerTitle: true,
        title: Text('ITC & TCR list'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: Icon(Icons.search, size: 40.0),
          ),
          // Icon(Icons.more_vert, size: 30.0),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add,
      //     size: 35.0,
      //   ),
      //   onPressed: () {
      //     print('Click Floating action Button');
      //   },
      // ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.add,
          size: 35.0,
        ),
        label: Text('ADD',style: TextStyle(
          fontSize: 20.0,
        ),),
        onPressed: () {
          print('Click Floating action Button');
        },
      ),
    );
  }
}

// class ที่ใช้สร้างเมนูใน drawer
class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  String subtitle;
  Function onTap;

  CustomListTile(this.icon, this.text, this.subtitle, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: InkWell(
          splashColor: Colors.blueAccent,
          onTap: onTap,
          child: Container(
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Icon(
                        icon,
                        color: Colors.grey,
                        size: 35.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              text,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[850],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
