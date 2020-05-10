import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Page สำหรับดูรายละเอียด
class DailyDetailPage extends StatefulWidget {
  // Explicit
  final DocumentSnapshot post; // สร้าง Object post

  DailyDetailPage({this.post}); // รับค่า Object จาก parameter DocumentSnapshot

  @override
  _DailyDetailPageState createState() => _DailyDetailPageState();
}

class _DailyDetailPageState extends State<DailyDetailPage> {

  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('User').getDocuments();
    return qn.documents;
  }

    @override
  void initState() {
    super.initState();
    _data = getPosts();
  }



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
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.network(
                  widget.post.data['UrlAvatar'],
                  fit: BoxFit.fitWidth,
                  height: 300.0,
                  width: 350.0,
                ),
                Text(widget.post.data['Name']),
                Text(widget.post.data['Email']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}