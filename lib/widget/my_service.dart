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

  Widget menuSignOut() {
    return ListTile(
      onTap: () => processSignOut(),
      title: Text('Sign Out'),
      leading: Icon(Icons.exit_to_app),
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
          showHead(),
          menuSignOut(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('My service'),
      ),
    );
  }
}
