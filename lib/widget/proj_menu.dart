import 'package:flutter/material.dart';
import 'package:mooconstructor14march/daily_report/daily_report_list.dart';
import 'package:mooconstructor14march/page/defectlist.dart';
import 'package:mooconstructor14march/page/ItcTcrListPage.dart';
import 'package:mooconstructor14march/widget/dashboard.dart';

class ProjMenuList extends StatefulWidget {
  @override
  _ProjMenuListState createState() => _ProjMenuListState();
}

class _ProjMenuListState extends State<ProjMenuList> {
// Explicit
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// Method
  _showSnackBar() {
    print('Show SnackBar here  !');
    final snackbar = SnackBar(
      content: Text('เวอร์ชั่นเต็ม ติดต่อ 089-126-9021'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.orangeAccent,
      action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            print('Press OK on SnackBar !');
          }),
    );
    // How to display SnackBar ?
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

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
    return new Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          // Daily Report
          CustomListTile(
              Icons.assessment, 'Daily Report', 'ใบรายงานการทำงานประจำวัน', () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (BuildContext context) {
              return DailyReportList(); // =====>>>> ITC & TCR List
            });
            Navigator.of(context).push(route); // กดย้อนกลับได้
          }),
          // Daily Request
          CustomListTile(
              Icons.assignment, 'Daily Request', 'ใบขออนุมัติทำงานประจำวัน',
              () {
            _showSnackBar();
          }),
          CustomListTile(Icons.format_paint, 'Material Approval',
              'ใบขออนุมัติวัสดุเพื่อใช้งาน', () => {_showSnackBar()}),
          CustomListTile(Icons.format_shapes, 'Shop Drawing Approval',
              'ใบขออนุมัติแบบเพื่อใช้งาน', () => {_showSnackBar()}),
          CustomListTile(Icons.build, 'Method Statement Approval',
              'ใบขออนุมัติวิธีการทำงาน', () => {_showSnackBar()}),
          CustomListTile(Icons.message, 'Site Information Letter',
              'จดหมายแจ้งเพื่อดำเนินการ', () => {_showSnackBar()}),
          CustomListTile(
              Icons.check_circle, 'ITC & TCR', 'การตรวจสอบและการทดสอบคุณภาพ',
              () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (BuildContext context) {
              return DashboardPage(); // =====>>>> ITC & TCR List
            });
            Navigator.of(context).push(route); // กดย้อนกลับได้
          }),
          CustomListTile(
              Icons.report, 'Defect List', 'ใบแจ้งงานที่มีข้อบกพร่อง', () {
            print('Click Defect list');
            //
            // Goto page
            MaterialPageRoute route =
                MaterialPageRoute(builder: (BuildContext context) {
              return DefectListPage(); // =====>>>> Defect List
            });
            //
            // กดย้อนกลับได้
            Navigator.of(context).push(route);
            //
            //
          }),
          CustomListTile(Icons.warning, 'Non-Conformance Report',
              'ใบแจ้งงานที่ไม่เป็นไปตามข้อกำหนด', () => {_showSnackBar()}),
        ],
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
