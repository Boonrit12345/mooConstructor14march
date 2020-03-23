import 'package:flutter/material.dart';
import 'package:mooconstructor14march/page/itctcrform.dart';
import 'package:mooconstructor14march/page/itctcrformchecklist.dart';
import 'package:mooconstructor14march/utility/my_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mooconstructor14march/utility/normal_dialog.dart';
import 'package:mooconstructor14march/widget/dashboard.dart';

class ItcTcrListPage extends StatefulWidget {
  @override
  _ItcTcrListPageState createState() => _ItcTcrListPageState();
}

class _ItcTcrListPageState extends State<ItcTcrListPage> {
  // Explicit
  Future _data;

  // readData
  Future getPosts() async {
    // ตัวแปรรับค่าจาก  Firestore
    var firestore = Firestore.instance;

    // รับค่าจากโฟลเดอร์ Itc ไปใส่ใน qn
    QuerySnapshot qn = await firestore.collection('Itc').getDocuments();

    // ส่งกลับค่าใน qn
    return qn.documents;
  }

  // Funtion
  // ฟังก์ชั่นนี้ จะ route ไปหน้าตาม record
  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ItcTcrCheckListPage(
                // post: post,
                )));
  }

  // Refesh screen เพื่อแสดงผล
  @override
  void initState() {
    super.initState();
    _data = getPosts();
  }

  // Method

  Widget showIconTitle(String string) {
    // return
  }

  Widget subMitButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child: IconButton(
        icon: Icon(Icons.add_circle, size: 40.0),
        onPressed: () {
          //
          // Goto page ITC & TCR Form
          MaterialPageRoute route =
              MaterialPageRoute(builder: (BuildContext context) {
            return DashboardPage(); // =====>>>> ITC & TCR Form
          });
          //
          // กดย้อนกลับได้
          Navigator.of(context).push(route);
          //
          //

//

          //   if (file == null) {
          //     normalDialog(context, 'No Avater', 'Please choose Camera or Gallory');
          //   } else if (levelString == null) {
          //     normalDialog(context, 'No level', 'Please choose Level');
          //   } else if (name == null ||
          //       name.isEmpty ||
          //       email == null ||
          //       email.isEmpty ||
          //       password == null ||
          //       password.isEmpty) {
          //     normalDialog(context, 'Have space', 'Please fill every blank');
          //   } else {
          //     authenThread();
          //   }
        },
      ),
    );
  }

  // สร้าง WIDGET เพื่อปฏิบัติการเรียกค่าจาก FIRESTORE
  Widget showListOfUser() {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading ...'),
              );
            } else {
              //  เรียกรับค่าจากโฟลเดอร์ User มาแสดงผล
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(snapshot.data[index].data['Job']),
                            subtitle: Text(snapshot.data[index].data['ItcNo']),

                            trailing: Text(snapshot.data[index].data['Date']),

                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.grey,
                              child: Text(snapshot.data[index].data['Icon']),
                            ),

                            // สร้าง route ไปที่หน้า DetailPage
                            // โดยสร้างฟังก์ชั่นชื่อ navigateToDetail()

                            // onTap: () => navigateToDetail(snapshot.data[index]),
                            onTap: () => navigateToDetail(snapshot.data[index]),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }

  Widget showListView() {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (_, index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text('งานผนังก่ออิฐมวลเบา #$index'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text('ITC No. :ITC/WD4/00$index/2563'),
                    ),
                    Container(
                      child: Text('ITC No. :ITC/WD4/00$index/2563'),
                    ),
                  ],
                ),
                leading: Icon(
                  Icons.check_circle_outline,
                  size: 35.0,
                  color: MyStyle().darkColor,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                // เมื่อกดปุ่มนี้
                onTap: () {
                  print('Click ITC & TCR LIST');
                  //
                  // Goto page ITC & TCR Form
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ItcTcrCheckListPage(); // =====>>>> ITC & TCR LIST VIEW
                  });
                  //
                  // กดย้อนกลับได้
                  Navigator.of(context).push(route);
                  //
                  //
                },
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // เนื้อหา
      body: showListOfUser(),
      // APP BAR จ้า
      appBar: AppBar(
        centerTitle: true,
        title: Text('ITC & TCR list'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: Icon(Icons.search, size: 40.0),
          ),
          subMitButton(),
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

      // //////
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(
      //     Icons.add,
      //     size: 35.0,
      //   ),
      //   label: Text(
      //     'ADD',
      //     style: TextStyle(
      //       fontSize: 20.0,
      //     ),
      //   ),
      //   onPressed: () {
      //     print('Click Floating action Button');
      //     //
      //     // Goto page ITC & TCR Form
      //     MaterialPageRoute route =
      //         MaterialPageRoute(builder: (BuildContext context) {
      //       return ItcTcrForm(); // =====>>>> ITC & TCR Form
      //     });
      //     //
      //     // กดย้อนกลับได้
      //     Navigator.of(context).push(route);
      //     //
      //     //
      //   },
      // ),
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

// Page สำหรับดูรายละเอียด
class DetailPage101 extends StatefulWidget {
  // Explicit
  final DocumentSnapshot post; // สร้าง Object post

  DetailPage101({this.post}); // รับค่า Object จาก parameter DocumentSnapshot

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage101> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Container(
        // child: ListTile(
        //   title: Text(widget.post.data['Name']),
        //   subtitle: Text(widget.post.data['Email']),
        //   leading: Image.network(widget.post.data['UrlAvatar']),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Text(widget.post.data['Project']),
                Text(widget.post.data['ItcNo']),
                // Text(widget.post.data['JobType']),
                Text(widget.post.data['Job']),
                // Text(widget.post.data['Location']),
                // Text(widget.post.data['GridLine']),
                Text(widget.post.data['Date']),
                // Text(widget.post.data['PlanDate']),
                // Text(widget.post.data['ActualDate']),
                // Text(widget.post.data['SubmitTo01']),
                Text(widget.post.data['Icon']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
