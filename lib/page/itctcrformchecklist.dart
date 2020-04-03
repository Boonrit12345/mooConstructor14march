import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mooconstructor14march/page/itc_a_page.dart';
import 'package:mooconstructor14march/page/itc_b_page.dart';
import 'package:mooconstructor14march/page/itc_c_page.dart';

import 'package:mooconstructor14march/utility/my_style.dart';

class ItcTcrCheckListPage extends StatefulWidget {
  final DocumentSnapshot
      post; // สร้าง Object post รับค่าจากการ route มาจาก page อื่น
  ItcTcrCheckListPage(
      {this.post}); // รับค่า Object จาก parameter DocumentSnapshot

  @override
  _ItcTcrCheckListPageState createState() => _ItcTcrCheckListPageState();
}

class _ItcTcrCheckListPageState extends State<ItcTcrCheckListPage> {
  // Explicit
  // GlobalKey<ScaffoldState> _key;
  List<String> _choices;
  // int _defaultChoiceIndex;
  String _defaultChoiceNo3;
  String _defaultChoiceNo4;
  String _defaultChoiceNo5;
  String _defaultChoiceNo6;
  String _defaultChoiceNo7;
  String _defaultChoiceNo8;

  String _pdfFile01;
  String _pdfFile02;

  @override
  void initState() {
    super.initState();

    _pdfFile01 = '';
    _pdfFile02 = '';

    _defaultChoiceNo3 = '';
    _defaultChoiceNo4 = '';
    _defaultChoiceNo5 = '';
    _defaultChoiceNo6 = '';
    _defaultChoiceNo7 = '';
    _defaultChoiceNo8 = '';
    _choices = [
      'ผ่าน',
      'แก้ไข',
      'ไม่ผ่าน',
    ];
  }
  // Method

  Widget choiceChipsNo3() {
    return Row(
      children: <Widget>[
        ChoiceChip(
          label: Text('ผ่าน'),
          selected: _defaultChoiceNo3 == 'ผ่าน',
          selectedColor: Colors.blue,
          onSelected: (bool selected) {
            setState(() {
              _defaultChoiceNo3 = selected ? 'ผ่าน' : null;
            });
          },
          backgroundColor: Colors.grey[350],
          labelStyle: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('แก้ไข'),
            selected: _defaultChoiceNo3 == 'แก้ไข',
            selectedColor: Colors.orange,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo3 = selected ? 'แก้ไข' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่ผ่าน'),
            selected: _defaultChoiceNo3 == 'ไม่ผ่าน',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo3 = selected ? 'ไม่ผ่าน' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo3 == 'ไม่มี',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo3 = selected ? 'ไม่มี' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget choiceChipsNo4() {
    return Row(
      children: <Widget>[
        ChoiceChip(
          label: Text('ผ่าน'),
          selected: _defaultChoiceNo4 == 'ผ่าน',
          selectedColor: Colors.blue,
          onSelected: (bool selected) {
            setState(() {
              _defaultChoiceNo4 = selected ? 'ผ่าน' : null;
            });
          },
          backgroundColor: Colors.grey[350],
          labelStyle: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('แก้ไข'),
            selected: _defaultChoiceNo4 == 'แก้ไข',
            selectedColor: Colors.orange,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo4 = selected ? 'แก้ไข' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่ผ่าน'),
            selected: _defaultChoiceNo4 == 'ไม่ผ่าน',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo4 = selected ? 'ไม่ผ่าน' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo4 == 'ไม่มี',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo4 = selected ? 'ไม่มี' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget choiceChipsNo5() {
    return Row(
      children: <Widget>[
        ChoiceChip(
          label: Text('ผ่าน'),
          selected: _defaultChoiceNo5 == 'ผ่าน',
          selectedColor: Colors.blue,
          onSelected: (bool selected) {
            setState(() {
              _defaultChoiceNo5 = selected ? 'ผ่าน' : null;
            });
          },
          backgroundColor: Colors.grey[350],
          labelStyle: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('แก้ไข'),
            selected: _defaultChoiceNo5 == 'แก้ไข',
            selectedColor: Colors.orange,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo5 = selected ? 'แก้ไข' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่ผ่าน'),
            selected: _defaultChoiceNo5 == 'ไม่ผ่าน',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo5 = selected ? 'ไม่ผ่าน' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo5 == 'ไม่มี',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo5 = selected ? 'ไม่มี' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget choiceChipsNo6() {
    return Row(
      children: <Widget>[
        ChoiceChip(
          label: Text('มี'),
          selected: _defaultChoiceNo6 == 'มี',
          selectedColor: Colors.blue,
          onSelected: (bool selected) {
            setState(() {
              _defaultChoiceNo6 = selected ? 'มี' : null;
            });
          },
          backgroundColor: Colors.grey[350],
          labelStyle: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo6 == 'ไม่มี',
            selectedColor: Colors.blue,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo6 = selected ? 'ไม่มี' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo6 == 'ไม่มี',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo6 = selected ? 'ไม่มี' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget choiceChipsNo7() {
    return Row(
      children: <Widget>[
        ChoiceChip(
          label: Text('มี'),
          selected: _defaultChoiceNo7 == 'มี',
          selectedColor: Colors.blue,
          onSelected: (bool selected) {
            setState(() {
              _defaultChoiceNo7 = selected ? 'มี' : null;
            });
          },
          backgroundColor: Colors.grey[350],
          labelStyle: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo7 == 'ไม่มี',
            selectedColor: Colors.blue,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo7 = selected ? 'ไม่มี' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo7 == 'ไม่มี',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo7 = selected ? 'ไม่มี' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget choiceChipsNo8() {
    return Row(
      children: <Widget>[
        ChoiceChip(
          label: Text('มี'),
          selected: _defaultChoiceNo8 == 'มี',
          selectedColor: Colors.blue,
          onSelected: (bool selected) {
            setState(() {
              _defaultChoiceNo8 = selected ? 'มี' : null;
            });
          },
          backgroundColor: Colors.grey[350],
          labelStyle: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo8 == 'ไม่มี',
            selectedColor: Colors.blue,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo8 = selected ? 'ไม่มี' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
          child: ChoiceChip(
            label: Text('ไม่มี'),
            selected: _defaultChoiceNo8 == 'ไม่มี',
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _defaultChoiceNo8 = selected ? 'ไม่มี' : null;
              });
            },
            backgroundColor: Colors.grey[350],
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget showTextDetail(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Icon(
              //   Icons.edit,
              //   color: Colors.grey[300],
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 5.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: MyStyle().darkColor,
                    fontSize: 20.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 2.0,
            thickness: 0.0,
          ),
        ],
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Icon(
          //   Icons.message,
          //   color: MyStyle().darkColor,
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 5.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itcTitleWidget() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: ListView(
          children: <Widget>[
            // showText('โครงการ'),
            Text('ชื่อโครงการ'),
            showTextDetail(widget.post.data['Project']),
            Text('ITC No.'),
            showTextDetail(widget.post.data['ITC_No']),
            // showText('ลักษณะงาน'),
            Text('ประเภทงาน'),
            showTextDetail(widget.post.data['JobType']),
            Text('ชื่องาน'),
            showTextDetail(widget.post.data['JobName']),
            // showText('Location'),
            Text('Location'),
            showTextDetail(widget.post.data['Location']),
            Text('Grid Line'),
            showTextDetail(widget.post.data['GridLine']),
            // showText('Date - Time'),
            Text('Date'),
            showTextDetail(widget.post.data['Date']),
            Text('Plan Date'),
            showTextDetail(widget.post.data['PlanDate']),
            Text('Actual Date'),
            showTextDetail(widget.post.data['ActualDate']),
            showText('Submit by'),
            showTextDetail('ผู้รับเหมา'),
            showText('Submit to'),
            showTextDetail('ผู้อนุมัติ'),
            SizedBox(height: 200.0),
          ],
        ),
      ),
    );
  }

  Widget showAttachFile() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        child: ListView(
          children: <Widget>[
            showText('A. ตรวจสอบก่อนการก่อสร้าง'),
            Text('1.เอกสารอนุมัติ Shop Dwg. เลขที่'),
            TextField(
              enabled: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: _pdfFile01,
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.cloud_upload,
                    size: 30.0,
                  ),
                  onPressed: () {
                    setState(() {
                      _pdfFile01 = 'sample.pdf';
                    });
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.launch,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print('object');
                    MaterialPageRoute route =
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ItcCPage();
                      // =====>>>>
                    });
                    Navigator.of(context).push(route);
                  },
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Text('2.เอกสารอนุมัติวัสดุเลขที่'),
            TextField(
              enabled: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: _pdfFile02,
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.cloud_upload,
                    size: 30.0,
                  ),
                  onPressed: () {
                    setState(() {
                      _pdfFile02 = 'sample2.pdf';
                    });
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.launch,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print('object');
                    MaterialPageRoute route =
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ItcCPage();
                      // =====>>>>
                    });
                    Navigator.of(context).push(route);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  Widget itc_A_Widget() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 15.0),
            Text('3.คุณภาพของวัสดุที่ใช้งาน'),
            choiceChipsNo3(),
            SizedBox(height: 15.0),
            Text(
                '4.ตำแหน่ง, แนว, ฉาก, ระยะ, ระดับ จากแนวเส้นอ้างอิงและระดับอ้างอิง'),
            choiceChipsNo4(),
            SizedBox(height: 15.0),
            Text('5.ตำแหน่ง,ระยะ.ขนาดเสาเอ็น หรือ Curb (ถ้ามี)'),
            choiceChipsNo5(),
            SizedBox(height: 15.0),
            Text('6.ตรวจสอบงานช่องเปิดทั้งหมด (งานสถาปัตย์)'),
            choiceChipsNo6(),
            SizedBox(height: 15.0),
            Text('7.ตรวจสอบงานระบบ'),
            choiceChipsNo7(),
            SizedBox(height: 15.0),
            Text('8.การฝังอุปกรณ์งานระบบประกอบคาร (ถ้ามี)'),
            choiceChipsNo8(),
            SizedBox(height: 15.0),
            Text('9.อื่นๆ'),
            TextField(),
            SizedBox(height: 200.0),
          ],
        ),
      ),
    );
  }

  Widget itc_B_Widget() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        child: ListView(
          children: <Widget>[
            showText('B. ตรวจสอบระหว่างการก่อสร้าง'),
            Text('1.การเตรียมวัสดุอุปกรณ์'),
            choiceChipsNo3(),
            SizedBox(height: 15.0),
            Text('2.ตำแหน่ง,ความสูง,ดิ่ง,ฉาก,แนว,ความหนาผนัง'),
            choiceChipsNo3(),
            SizedBox(height: 15.0),
            Text('3.เสาเอ็น หรือ Curb (ถ้ามี)'),
            choiceChipsNo8(),
            SizedBox(height: 15.0),
            Text('   3.1 ขนาดหลังก่ออิฐ, ระยะ'),
            choiceChipsNo3(),
            SizedBox(height: 15.0),
            Text('   3.2 ขนาด, ความลึก ระยะรูเจาะ เสียบเหล็กใช้ Epoxy'),
            choiceChipsNo3(),
            SizedBox(height: 15.0),
            Text('   3.3 ขนาดจำนวนเหล็กเสริม, เหล็กปลอก'),
            choiceChipsNo3(),
            SizedBox(height: 15.0),
            Text('4.เหล็กฝากยึดอิฐ'),
            choiceChipsNo4(),
            SizedBox(height: 15.0),
            Text('5.วิธีการก่อ / การผสมปูน'),
            choiceChipsNo5(),
            SizedBox(height: 15.0),
            Text('6.ทับหลัง'),
            choiceChipsNo6(),
            SizedBox(height: 15.0),
            Text('7.ตำแหน่ง, ขนาดช่องเปิด(ถ้ามี)'),
            choiceChipsNo7(),
            SizedBox(height: 15.0),
            Text('8.ตำแหน่งการปิดตั้งวงกบ(ถ้ามี)'),
            choiceChipsNo8(),
            SizedBox(height: 15.0),
            Text(
                '9.ตำแหน่ง, ขนาดความหนาของโฟม บริเวณรอยต่อชนท้องพื้น, ชนท้องคานคาน'),
            choiceChipsNo3(),
            SizedBox(height: 200.0),
          ],
        ),
      ),
    );
  }


  Widget itc_C_Widget() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        child: ListView(
          children: <Widget>[
            showText('C. ตรวจสอบหลังการก่อสร้าง'),
            Text('1.ตรวจสอบรอยร้าว และตำหนิ'),
            choiceChipsNo3(),
            SizedBox(height: 200.0),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        // body: Text('Body'),
        // body: TabBarView(children: null),
        appBar: AppBar(
          centerTitle: true,
          title: Text('ITC&TCR Check'),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.check_circle,
                  size: 30.0,
                  color: Colors.greenAccent,
                ),
                text: 'หัวเรื่อง',
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle,
                  size: 30.0,
                  color: Colors.greenAccent,
                ),
                text: 'ไฟล์แนบ',
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle,
                  size: 30.0,
                  color: Colors.greenAccent,
                ),
                text: 'A.ก่อนก่อสร้าง',
              ),
              Tab(
                icon: Icon(
                  Icons.error,
                  color: Colors.redAccent,
                  size: 30.0,
                ),
                text: 'B.ระหว่างก่อสร้าง',
              ),
              Tab(
                icon: Icon(
                  Icons.radio_button_unchecked,
                  size: 30.0,
                ),
                text: 'C.หลังก่อสร้าง',
              ),
            ],
          ),
          actions: <Widget>[],
        ),
        body: TabBarView(
          children: <Widget>[
            // ส่วนต่อไปนี้ สามารถเรียกใช้หน้า page ได้เลย เรียงตาม Tab
            itcTitleWidget(), // Widget in this page
            showAttachFile(),
            itc_A_Widget(),
            itc_B_Widget(),
            itc_C_Widget(),
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   icon: Icon(
        //     Icons.send,
        //     size: 35.0,
        //   ),
        //   label: Text(
        //     'Submit',
        //     style: TextStyle(
        //       fontSize: 20.0,
        //     ),
        //   ),
        //   onPressed: () {
        //     print('Click Floating action Button');
        //     Navigator.of(context).pop();
        //   },
        // ),
      ),
    );
  }
}
