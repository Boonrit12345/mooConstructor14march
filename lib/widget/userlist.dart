import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

// Explicit
Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection('User').getDocuments();

    return qn.documents;
  }

  // Funtion
  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  post: post,
                )));
  }

  @override
  void initState() {
    super.initState();
    _data = getPosts();
  }

  // Method
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
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(snapshot.data[index].data['Name']),
                            subtitle: Text(snapshot.data[index].data['Email']),
                            trailing: Text(snapshot.data[index].data['Level']),

                            // leading: Image.network(snapshot.data[index].data['UrlAvatar']),

                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                  snapshot.data[index].data['UrlAvatar']),
                            ),

                            // สร้าง route ไปที่หน้า DetailPage
                            // โดยสร้างฟังก์ชั่นชื่อ navigateToDetail()
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







  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}


// Page สำหรับดูรายละเอียด
class DetailPage extends StatefulWidget {
  // Explicit
  final DocumentSnapshot post; // สร้าง Object post

  DetailPage({this.post}); // รับค่า Object จาก parameter DocumentSnapshot

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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