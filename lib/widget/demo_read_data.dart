import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoReadData extends StatefulWidget {
  @override
  _DemoReadDataState createState() => _DemoReadDataState();
}

class _DemoReadDataState extends State<DemoReadData> {
  // Field
  Firestore firestore = Firestore.instance;
  String subjectDocument, namePaper;
  List<String> headTitles = List();
  List<String> nameTitles = List();
  List<List<String>> namesSubDocs = List();
  List<String> keySubDoc = ['Date', 'No', 'Signed', 'Yes'];
  List<List<String>> detailSubDocs = List();

  // Method
  @override
  void initState() {
    super.initState();
    readDataBase();
  }

// อ่านรายละเอียดหัวกระดาษ
  Future<void> readDataBase() async {
    String firstCollection = 'TryMaster123';
    CollectionReference collectionReference =
        firestore.collection(firstCollection);

    // Find Detail Document
    String firstDocument = 'RITC';
    await collectionReference.document(firstDocument).snapshots().listen(
      (response) {
        setState(() {
          subjectDocument = response.data['Subject'];
          namePaper = response.data['NamPaper'];
        });
        print('subjectDocument = $subjectDocument , namePaper = $namePaper');
      },
    );

    await collectionReference
        .document(firstDocument)
        .collection('RITC')
        .snapshots()
        .listen(
      (response) {
        int i = 0;
        for (var map in response.documents) {
          List<String> names = List();
          namesSubDocs.add(names);
          detailSubDocs.add(names);
          i++;
          String nameDocument = map.documentID;
          print('nameDocument ==>> $nameDocument');
          headTitles.add(nameDocument);
          if (i == response.documents.length) {

            // Find Detail HeadTitle
            createNameTitle(collectionReference, firstDocument);
          }
        }
      },
    );
  }

  

  Future createNameTitle(
      CollectionReference collectionReference, String firstDocument) async {
    if (headTitles.length != 0) {
      String secondCollection = 'RITC';
      // String headTitle = 'HeadTitle1';

      int index = 0;

      for (var nameDocument in headTitles) {
        await collectionReference
            .document(firstDocument)
            .collection(secondCollection)
            .document(nameDocument)
            .snapshots()
            .listen(
          (response) {
            String string = response.data['NameTitle'];
            print('NameTitle ==> $nameTitles');

            readAllItem(collectionReference, firstDocument, secondCollection,
                nameDocument, index);

            index++;

            setState(() {
              nameTitles.add(string);
            });
          },
        );
      }
    }
  }

  Future<void> readAllItem(CollectionReference collectionReference,
      String firstDoc, String secondCol, String nameDoc, int index) async {
    String item = 'Item';
    List<String> nameitems = List();
    int i = 0;
    await collectionReference
        .document(firstDoc)
        .collection(secondCol)
        .document(nameDoc)
        .collection(item)
        .snapshots()
        .listen(
      (response) {
        for (var nameSubDoc in response.documents) {
          i++;
          String string = nameSubDoc.data['Name'];
          String docItem = nameSubDoc.documentID;
          print('docItem = $docItem');
          
          if (docItem !=null) {
            readAllSubDoc(collectionReference, firstDoc, secondCol, nameDoc, item,
              docItem, index);
          }

          nameitems.add(string);
          if (i == response.documents.length) {
            setState(() {
              namesSubDocs[index] = nameitems;
            });
          }
        }
      },
    );
  }

  Future<void> readAllSubDoc(
      CollectionReference collectionReference,
      String firstDoc,
      String secondCol,
      String nameDoc,
      String docItem,
      String itemDoc,
      int index) async {
        print('readAllSubDoc work');
    await collectionReference
        .document(firstDoc)
        .collection(secondCol)
        .document(nameDoc)
        .collection(itemDoc)
        .document(docItem)
        .collection('SubDoc')
        .document('SubDoc')
        .snapshots()
        .listen(
      (response) {
        List<String> list = List();
        for (var i = 0; i < keySubDoc.length; i++) {
          list.add(response.data[keySubDoc[i]]);
          if (i == (keySubDoc.length - 1)) {
            setState(() {
              detailSubDocs[index] = list;
            });
          }
        }
      },
    );
  }

  Widget showText(String title, String detail) {
    if (detail == null) {
      detail = '?';
    }
    return Text('$title ==>> $detail');
  }

  Widget showListHeadTitle() {
    return nameTitles.length == 0
        ? CircularProgressIndicator()
        : showListView();
  }

  Expanded showListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: nameTitles.length,
        itemBuilder: (value, index) => Column(
          children: <Widget>[
            showHead(index),
            showListItem(index),
          ],
        ),
      ),
    );
  }

  Row showHead(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(nameTitles[index]),
      ],
    );
  }

  Widget showListItem(int index1) => ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: namesSubDocs[index1].length,
      itemBuilder: (value, index2) {
        return Column(
          children: <Widget>[
            Text(namesSubDocs[index1][index2]),
            showDetail(index1, index2),
          ],
        );
      });

  Widget showDetail(int index1, int index2) {
    return ListView.builder(
      itemCount: detailSubDocs[index1][index2].length,
      itemBuilder: (value, index) => Text('test'),
    );
  }

  
  Column detailDocument() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showText('Subject', subjectDocument),
        showText('NamwPaper', namePaper),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Column(
        children: <Widget>[
          detailDocument(),
          showListHeadTitle(),
        ],
      ),
    );
  }

}
