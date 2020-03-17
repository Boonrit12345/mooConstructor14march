import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mooconstructor14march/utility/my_constant.dart';
import 'package:mooconstructor14march/widget/authen.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// Field
  String uidString, urlLogin, nameLogin, levelLogin;

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
        // onTap: () => processSignOut(),
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
        // onTap: () => processSignOut(),
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
        // onTap: () => processSignOut(),
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
        // onTap: () => processSignOut(),
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
        // onTap: () => processSignOut(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showBodyListView(),
      //
      // show Drawer
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('My Project'),
      ),
    );
  }
}
