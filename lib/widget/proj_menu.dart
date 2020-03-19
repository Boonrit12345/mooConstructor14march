import 'package:flutter/material.dart';

class ProjMenuList extends StatefulWidget {
  @override
  _ProjMenuListState createState() => _ProjMenuListState();
}

class _ProjMenuListState extends State<ProjMenuList> {
// Explicit

// Method

  Widget dailyReport() {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        // onTap: () => processSignOut(),
        title: Text(
          'Dail Report',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text('ใบรายงานการทำงานประจำวัน'),
        leading: Icon(
          Icons.list,
          size: 40.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CustomListTile(Icons.assessment, 'Daily Report', 'ใบรายงานการทำงานประจำวัน', () => {}),
        CustomListTile(Icons.assignment, 'Daily Request', 'ใบขออนุมัติทำงานประจำวัน', () => {}),
        CustomListTile(Icons.format_paint, 'Material Approval', 'ใบขออนุมัติวัสดุเพื่อใช้งาน', () => {}),
        CustomListTile(Icons.format_shapes, 'Shop Drawing Approval', 'ใบขออนุมัติแบบเพื่อใช้งาน', () => {}),
        CustomListTile(Icons.build, 'Method Statement Approval', 'ใบขออนุมัติวิธีการทำงาน', () => {}),
        CustomListTile(Icons.message, 'Site Information Letter', 'จดหมายแจ้งเพื่อดำเนินการ', () => {}),
        CustomListTile(Icons.check_circle, 'ITC & TCR', 'การตรวจสอบและการทดสอบคุณภาพ', () => {}),
        CustomListTile(Icons.report, 'Defect List', 'ใบแจ้งงานที่มีข้อบกพร่อง', () => {}),
        CustomListTile(Icons.warning, 'Non-Conformance Report', 'ใบแจ้งงานที่ไม่เป็นไปตามข้อกำหนด', () => {}),
      ],
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
