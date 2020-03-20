import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mooconstructor14march/utility/my_constant.dart';
import 'package:mooconstructor14march/utility/my_style.dart';

import 'package:mooconstructor14march/widget/authen.dart';
import 'package:mooconstructor14march/widget/my_proj.dart';
import 'package:mooconstructor14march/widget/proj_menu.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// Explicit
  String uidString, urlLogin, nameLogin, levelLogin;
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];
  Widget currentWidget = ProjMenuList();
  int _currentIndex = 0;

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
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Machu-Picchu-around-sunset.jpg",
        name: "Machu Picchu",
        country: "Peru"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Machu-Picchu-around-sunset.jpg",
        name: "Machu Picchu",
        country: "Peru"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Machu-Picchu-around-sunset.jpg",
        name: "Machu Picchu",
        country: "Peru"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Machu-Picchu-around-sunset.jpg",
        name: "Machu Picchu",
        country: "Peru"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Machu-Picchu-around-sunset.jpg",
        name: "Machu Picchu",
        country: "Peru"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Machu-Picchu-around-sunset.jpg",
        name: "Machu Picchu",
        country: "Peru"),
    Place(
        imageUrl:
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Chichen-Itza-at-night.jpg",
        name: "Chichén Itzá",
        country: "Mexico"),
  ];

// Method
  @override
  void initState() {
    super.initState();
    findUidFormAuthen();
  }

  Future<void> findUidFormAuthen() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.currentUser().then((value) {
      uidString = value.uid;
      print('uid = $uidString');
      readUserFormFireStore();
    });
  }

  Future<void> readUserFormFireStore() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('User');
    await collectionReference.document(uidString).snapshots().listen((event) {
      print('event ====>>> ${event.data}');
      setState(() {
        urlLogin = event.data['UrlAvatar'];
        nameLogin = event.data['Name'];
        levelLogin = event.data['Level'];
      });
    });
  }

  Widget myProjectList() {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        onTap: () {
          // go to  ====>>> ProjMenuList
          setState(() {
            print('Click My Project');
            currentWidget = ProjMenuList();
          });
          Navigator.of(context).pop();
        },
        title: Text('My Project'),
        subtitle: Text('โครงการที่รับผิดชอบ'),
        leading: Icon(
          Icons.view_agenda,
          size: 30.0,
        ),
      ),
    );
  }

  Widget listAllProjectList() {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        onTap: () {
          setState(() {
            print('Click My Project');
            currentWidget = MyProjList();
          });
          Navigator.of(context).pop();
        },
        title: Text('All Project'),
        subtitle: Text('โครงการทั้งหมด'),
        leading: Icon(
          Icons.view_list,
          size: 30.0,
        ),
      ),
    );
  }

  Widget myInboxMessage() {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        onTap: () {
          setState(() {
            print('Click Inbox message');
            // currentWidget = MyProjList();
          });
          Navigator.of(context).pop();
        },
        title: Text('Message'),
        subtitle: Text('กล่องข้อความ'),
        leading: Icon(
          Icons.question_answer,
          size: 30.0,
        ),
      ),
    );
  }

  Widget myProfile() {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        onTap: () {
          setState(() {
            print('Click My Profile');
            // currentWidget = MyProjList();
          });
          Navigator.of(context).pop();
        },
        title: Text('Profile'),
        subtitle: Text('ข้อมูลส่วนตัว'),
        leading: Icon(
          Icons.account_circle,
          size: 30.0,
        ),
      ),
    );
  }

  Widget mySetting() {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        onTap: () {
          setState(() {
            print('Click Setting');
            // currentWidget = MyProjList();
          });
          Navigator.of(context).pop();
        },
        title: Text('Setting'),
        subtitle: Text('การตั้งค่า'),
        leading: Icon(
          Icons.settings,
          size: 30.0,
        ),
      ),
    );
  }

  Widget menuSignOut() {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        onTap: () => processSignOut(),
        title: Text('Sign Out'),
        subtitle: Text('ออกจากระบบ'),
        leading: Icon(
          Icons.exit_to_app,
          size: 30.0,
        ),
      ),
    );
  }

  Future<void> processSignOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut().then((value) {
      MaterialPageRoute route = MaterialPageRoute(builder: (value) => Authen());
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    });
  }

  Widget showAvatar() {
    return CircleAvatar(
      backgroundImage: urlLogin == null
          ? NetworkImage(MyConstant().urlNoAvatar)
          : NetworkImage(urlLogin),
    );
  }

  Widget showHead() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: <Color>[Colors.blue, Colors.blue[100]])),
      currentAccountPicture: showAvatar(),
      accountName: showName(),
      accountEmail: showLevel(),
    );
  }

  Text showName() {
    return nameLogin == null ? Text('Name') : Text(nameLogin);
  }

  Text showLevel() {
    return levelLogin == null ? Text('Level') : Text(levelLogin);
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // DrawerHeader(child: null),
          showHead(),
          myProjectList(),
          listAllProjectList(),
          myInboxMessage(),
          myProfile(),
          mySetting(),
          menuSignOut(),
          // CustomListTileDrawer(
          //     Icons.view_agenda, 'My Project', 'โครงการที่รับผิดชอบ', () {
          //   // go to  ====>>> ProjMenuList
          //   setState(() {
          //     print('Click My Project');
          //     currentWidget = ProjMenuList();
          //   });
          //   Navigator.of(context).pop();
          //   //
          //   //
          // }),
        ],
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

// =======================================================
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

// แสดงรูปแบบ กริดวิว
  Widget showImageGrideView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: wonders.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: <Widget>[
              Container(
                  child: Image.network(
                    wonders[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                  height: 150),
              Text(wonders[index].name),
              Text(wonders[index].country),
            ],
          ));
        },
      ),
    );
  }

  Widget showHorizontalListView() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Image.network(
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Taj-Mahal.jpg"),
        Image.network(
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Christ-the-Redeemer.jpg"),
        Image.network(
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2016/03/petra-jordan9.jpg"),
        Image.network(
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Great-Wall-of-China-view.jpg"),
        Image.network(
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/View-of-the-Colosseum.jpg"),
        Image.network(
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Machu-Picchu-around-sunset.jpg"),
        Image.network(
            "https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/02/Chichen-Itza-at-night.jpg"),
      ],
    );
  }

// แสดง Listview แนวนอน
  Widget showListViewHorizontal() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Card(
              color: Colors.blue,
              child: Container(
                child: Center(
                  child: Text(
                    numbers[index].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// ======================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // type: BottomNavigationBarType.fixed,
        iconSize: 30,
        // selectedFontSize: 25,
        // unselectedFontSize: 20,
        unselectedItemColor: Colors.blue[200],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text('Camera'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Person'),
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

      //
      // show Drawer
      drawer: showDrawer(),
      appBar: AppBar(
        centerTitle: true, // ทำให้ title อยู่กลาง
        title: Text('My Project'),
        // leading: Icon(Icons.search),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: Icon(Icons.search, size: 35.0),
          ),
          // Icon(Icons.more_vert, size: 30.0),
        ],
      ),
    );
  }
}

// สร้าง class ให้ตัวแปร (สร้างตัวตนตัวแปร)
class Place {
  String imageUrl;
  String name;
  String country;

  Place({this.imageUrl, this.name, this.country});
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

// class ที่ใช้สร้างเมนูใน drawer
class CustomListTileDrawer extends StatelessWidget {
  IconData icon;
  String text;
  String subtitle;
  Function onTap;

  CustomListTileDrawer(this.icon, this.text, this.subtitle, this.onTap);

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
                      // Icon หน้าข้อความ
                      child: Icon(
                        icon,
                        color: Colors.grey,
                        size: 30.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // ข้อความ title
                            Text(
                              text,
                              style: TextStyle(
                                fontSize: 15.0,
                                // fontWeight: FontWeight.bold,
                                color: Colors.grey[850],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              // ข้อความ subtitle
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
