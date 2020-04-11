import 'package:flutter/material.dart';
import 'package:mooconstructor14march/daily_report/Features.dart';
import 'package:mooconstructor14march/daily_report/MainGridList.dart';
import 'package:mooconstructor14march/daily_report/add_daily_image.dart';
import 'package:mooconstructor14march/daily_report/crud_Picture_daily_report.dart';
import 'package:mooconstructor14march/daily_report/crud_daily_report.dart';
import 'package:bezier_chart/bezier_chart.dart';

class DailyReportDetail extends StatefulWidget {
  @override
  _DailyReportDetailState createState() => _DailyReportDetailState();
}

class _DailyReportDetailState extends State<DailyReportDetail> {
  // Explicit
  String carModel;
  String carColor;

  var cars;
  crudPictureDailyReportMedthods crudObj = new crudPictureDailyReportMedthods();

  // Method

  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        cars = results;
      });
    });
    super.initState();
  }

  Widget sample5(BuildContext context) {
    final fromDate = DateTime(2012, 11, 22);
    final toDate = DateTime.now();

    final date1 = DateTime.now().subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));

    final date3 = DateTime.now().subtract(Duration(days: 300));
    final date4 = DateTime.now().subtract(Duration(days: 320));

    final date5 = DateTime.now().subtract(Duration(days: 650));
    final date6 = DateTime.now().subtract(Duration(days: 652));

    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.YEARLY,
          fromDate: fromDate,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              label: "Duty",
              onMissingValue: (dateTime) {
                if (dateTime.year.isEven) {
                  return 20.0;
                }
                return 5.0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
                DataPoint<DateTime>(value: 100, xAxis: date3),
                DataPoint<DateTime>(value: 100, xAxis: date4),
                DataPoint<DateTime>(value: 40, xAxis: date5),
                DataPoint<DateTime>(value: 47, xAxis: date6),
              ],
            ),
            BezierLine(
              label: "Flight",
              lineColor: Colors.black26,
              onMissingValue: (dateTime) {
                if (dateTime.month.isEven) {
                  return 10.0;
                }
                return 3.0;
              },
              data: [
                DataPoint<DateTime>(value: 20, xAxis: date1),
                DataPoint<DateTime>(value: 30, xAxis: date2),
                DataPoint<DateTime>(value: 150, xAxis: date3),
                DataPoint<DateTime>(value: 80, xAxis: date4),
                DataPoint<DateTime>(value: 45, xAxis: date5),
                DataPoint<DateTime>(value: 45, xAxis: date6),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            backgroundGradient: LinearGradient(
              colors: [
                Colors.red[300],
                Colors.red[400],
                Colors.red[400],
                Colors.red[500],
                Colors.red,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            footerHeight: 30.0,
          ),
        ),
      ),
    );
  }

  Widget sample4(BuildContext context) {
    final fromDate = DateTime(2018, 11, 22);
    final toDate = DateTime.now();

    final date1 = DateTime.now().subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));

    final date3 = DateTime.now().subtract(Duration(days: 35));
    final date4 = DateTime.now().subtract(Duration(days: 36));

    final date5 = DateTime.now().subtract(Duration(days: 65));
    final date6 = DateTime.now().subtract(Duration(days: 64));

    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.MONTHLY,
          fromDate: fromDate,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              label: "Duty",
              onMissingValue: (dateTime) {
                if (dateTime.month.isEven) {
                  return 10.0;
                }
                return 5.0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
                DataPoint<DateTime>(value: 20, xAxis: date3),
                DataPoint<DateTime>(value: 80, xAxis: date4),
                DataPoint<DateTime>(value: 14, xAxis: date5),
                DataPoint<DateTime>(value: 30, xAxis: date6),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            backgroundColor: Colors.red,
            footerHeight: 30.0,
          ),
        ),
      ),
    );
  }

  Widget sample3(BuildContext context) {
    final fromDate = DateTime(2019, 05, 22);
    final toDate = DateTime.now();

    final date1 = DateTime.now().subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));

    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          fromDate: fromDate,
          bezierChartScale: BezierChartScale.WEEKLY,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              label: "Duty",
              onMissingValue: (dateTime) {
                if (dateTime.day.isEven) {
                  return 10.0;
                }
                return 5.0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            backgroundColor: Colors.red,
            footerHeight: 30.0,
          ),
        ),
      ),
    );
  }

  Widget sample2(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: const [0, 3, 10, 15, 20, 25, 30, 35],
          series: const [
            BezierLine(
              label: "Custom 1",
              data: const [
                DataPoint<double>(value: 10, xAxis: 0),
                DataPoint<double>(value: 130, xAxis: 5),
                DataPoint<double>(value: 50, xAxis: 10),
                DataPoint<double>(value: 150, xAxis: 15),
                DataPoint<double>(value: 75, xAxis: 20),
                DataPoint<double>(value: 0, xAxis: 25),
                DataPoint<double>(value: 5, xAxis: 30),
                DataPoint<double>(value: 45, xAxis: 35),
              ],
            ),
            BezierLine(
              lineColor: Colors.blue,
              lineStrokeWidth: 2.0,
              label: "Custom 2",
              data: const [
                DataPoint<double>(value: 5, xAxis: 0),
                DataPoint<double>(value: 50, xAxis: 5),
                DataPoint<double>(value: 30, xAxis: 10),
                DataPoint<double>(value: 30, xAxis: 15),
                DataPoint<double>(value: 50, xAxis: 20),
                DataPoint<double>(value: 40, xAxis: 25),
                DataPoint<double>(value: 10, xAxis: 30),
                DataPoint<double>(value: 30, xAxis: 35),
              ],
            ),
            BezierLine(
              lineColor: Colors.black,
              lineStrokeWidth: 2.0,
              label: "Custom 3",
              data: const [
                DataPoint<double>(value: 5, xAxis: 0),
                DataPoint<double>(value: 10, xAxis: 5),
                DataPoint<double>(value: 35, xAxis: 10),
                DataPoint<double>(value: 40, xAxis: 15),
                DataPoint<double>(value: 40, xAxis: 20),
                DataPoint<double>(value: 40, xAxis: 25),
                DataPoint<double>(value: 9, xAxis: 30),
                DataPoint<double>(value: 11, xAxis: 35),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 2.0,
            verticalIndicatorColor: Colors.black12,
            showVerticalIndicator: true,
            contentWidth: MediaQuery.of(context).size.width * 2,
            backgroundColor: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget sample1(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
          series: const [
            BezierLine(
              data: const [
                DataPoint<double>(value: 10, xAxis: 0),
                DataPoint<double>(value: 130, xAxis: 5),
                DataPoint<double>(value: 50, xAxis: 10),
                DataPoint<double>(value: 150, xAxis: 15),
                DataPoint<double>(value: 75, xAxis: 20),
                DataPoint<double>(value: 0, xAxis: 25),
                DataPoint<double>(value: 5, xAxis: 30),
                DataPoint<double>(value: 45, xAxis: 35),
              ],
            ),
          ],
          config: BezierChartConfig(
              verticalIndicatorStrokeWidth: 3.0,
              verticalIndicatorColor: Colors.black26,
              showVerticalIndicator: true,
              backgroundColor: Colors.red,
              snap: false),
        ),
      ),
    );
  }

  Widget _imageList2() {
    if (cars != null) {
      return Container(
        height: 280.0,
        child: StreamBuilder(
          stream: cars,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, i) {
                  return Container(
                    width: 220.0,
                    height: 220.0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              children: <Widget>[
                                Image.network(
                                  snapshot
                                      .data.documents[i].data['urlImageDaily'],
                                  width: 220,
                                  height: 170,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                    top: 16,
                                    left: 160,
                                    child: Container(
                                      height: 25,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                          color:
                                              Colors.black, //Color(0xff0F0F0F),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            )
                                          ]),
                                      child: Center(
                                        child: Text(
                                          snapshot.data.documents[i]
                                              .data['unitImage'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 5,
                            margin: EdgeInsets.all(5),
                          ),
                          ListTile(
                              title: Text(snapshot
                                  .data.documents[i].data['titleImage']),
                              subtitle: Text(snapshot
                                  .data.documents[i].data['explainImage']),
                              // onLongPress: () {
                              //   crudObj.deleteData(
                              //       snapshot.data.documents[i].documentID);
                              // },
                              trailing: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    crudObj.deleteData(
                                        snapshot.data.documents[i].documentID);
                                  },
                                ),
                              )),
                        ]),
                  );
                },
              );
            }
          },
        ),
      );
    } else {
      return Center(child: Text('Loading, Please wait..'));
    }
  }

  Widget acceptButton() {
    return Container(
      width: 150.0,
      height: 45.0,
      child: RaisedButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'Accept',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget showMachineDataTable() {
    return Container(
      child: DataTable(
        columnSpacing: 20.0,
        columns: [
          DataColumn(label: Text('No.')),
          DataColumn(label: Text('ประเภท')),
          DataColumn(label: Text('จำนวน')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('รถเบคโฮ PC120')),
              DataCell(Text('1')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('2')),
              DataCell(Text('รถบรรทุก 6 ล้อ')),
              DataCell(Text('2')),
            ],
          ),
        ],
        sortColumnIndex: 0,
        sortAscending: true,
      ),
    );
  }

  Widget showMaterialDataTable() {
    return Container(
      child: DataTable(
        columnSpacing: 20.0,
        columns: [
          DataColumn(label: Text('No.')),
          DataColumn(label: Text('ประเภท')),
          DataColumn(label: Text('จำนวน')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('เหล็กเส้น')),
              DataCell(Text('10')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('2')),
              DataCell(Text('เหล็กรูปพรรณ')),
              DataCell(Text('9')),
            ],
          ),
        ],
        sortColumnIndex: 0,
        sortAscending: true,
      ),
    );
  }

  // ตารางพนักงาน
  Widget showStaffDataTable() {
    return Container(
      child: DataTable(
        columnSpacing: 20.0,
        columns: [
          DataColumn(label: Text('No.')),
          DataColumn(label: Text('พนักงาน')),
          DataColumn(label: Text('จำนวน')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('ผู้อำนวยการโครงการ')),
              DataCell(Text('10')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('2')),
              DataCell(Text('ผู้จัดการโครงการ')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('3')),
              DataCell(Text('วิศวกรโครงการ')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('4')),
              DataCell(Text('ผช. วิศวกรโครงการ')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('5')),
              DataCell(Text('วิศวกร')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('6')),
              DataCell(Text('สถาปนิค')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('7')),
              DataCell(Text('หัวหน้าโฟร์แมน')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('8')),
              DataCell(Text('โฟร์แมน')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('9')),
              DataCell(Text('เขียนแบบ')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('10')),
              DataCell(Text('ธุรการ')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('11')),
              DataCell(Text('สโตร์')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('12')),
              DataCell(Text('ช่างซ่อมบำรุง')),
              DataCell(Text('9')),
            ],
          ),
        ],
      ),
    );
  }

  // ตารางแรงงาน
  Widget showManpoerDataTable() {
    return Container(
      child: DataTable(
        columnSpacing: 20.0,
        columns: [
          DataColumn(label: Text('No.')),
          DataColumn(label: Text('ประเภทแรงงาน')),
          DataColumn(label: Text('จำนวน')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('ช่างไม้')),
              DataCell(Text('10')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('2')),
              DataCell(Text('ช่างเหล็ก')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('3')),
              DataCell(Text('ช่างคอนกรีต')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('4')),
              DataCell(Text('ช่างไฟฟ้า')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('5')),
              DataCell(Text('ช่างประปา')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('6')),
              DataCell(Text('ช่างแอร์')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('7')),
              DataCell(Text('ช่างกล')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('8')),
              DataCell(Text('ช่างสำรวจ')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('9')),
              DataCell(Text('ช่างเชื่อม')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('10')),
              DataCell(Text('ช่างปูน')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('11')),
              DataCell(Text('ช่างกระเบื้อง')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('12')),
              DataCell(Text('ช่างฝ้า')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('13')),
              DataCell(Text('ช่างอลูมิเนียม')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('14')),
              DataCell(Text('ช่างทาสี')),
              DataCell(Text('9')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('15')),
              DataCell(Text('ช่างเบ็ดเตล็ด')),
              DataCell(Text('9')),
            ],
          ),
        ],
      ),
    );
  }

  Widget showProgressDataTable() {
    return Container(
      child: DataTable(
        columnSpacing: 20.0,
        columns: [
          DataColumn(label: Text('No.')),
          DataColumn(label: Text('รายการ')),
          DataColumn(label: Text('%Actual')),
          DataColumn(label: Text('%Plan')),
          DataColumn(label: Text('%Delay')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('aaaaaa')),
              DataCell(Text('10%')),
              DataCell(Text('10%')),
              DataCell(Text('0%')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('2')),
              DataCell(Text('aaaaaa')),
              DataCell(Text('10%')),
              DataCell(Text('10%')),
              DataCell(Text('0%')),
            ],
          ),
        ],
        sortColumnIndex: 0,
        sortAscending: true,
      ),
    );
  }

  Widget showProgressDataTable2() {
    return Container(
      child: DataTable(
        columnSpacing: 20.0,
        columns: [
          DataColumn(label: Text('no.')),
          DataColumn(
            label: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text('รายละเอียด'),
            ),
          ),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(TextField(
                decoration: InputDecoration(border: InputBorder.none),
              )),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('2')),
              DataCell(TextField(
                decoration: InputDecoration(border: InputBorder.none),
              )),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('3')),
              DataCell(TextField(
                decoration: InputDecoration(border: InputBorder.none),
              )),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('4')),
              DataCell(TextField(
                decoration: InputDecoration(border: InputBorder.none),
              )),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('5')),
              DataCell(TextField(
                decoration: InputDecoration(border: InputBorder.none),
              )),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('6')),
              DataCell(TextField(
                decoration: InputDecoration(border: InputBorder.none),
              )),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('7')),
              DataCell(TextField(
                decoration: InputDecoration(border: InputBorder.none),
              )),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('8')),
              DataCell(TextField(
                decoration: InputDecoration(border: InputBorder.none),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget showTextTitle(String _titleText, String _trailingText,
      double _fontSize, Function onClick) {
    return ListTile(
      title: Text(
        _titleText,
        style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 25.0,
            width: 80.0,
            child: FlatButton(
              onPressed: onClick,
              child: Text(_trailingText),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget showTextSubject(String _txtSubject) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(_txtSubject,
          style: TextStyle(
              fontFamily: 'ConcertOne-Regular',
              fontSize: 18,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget showCoverReport() {
    return Column(
      children: <Widget>[
        // Text('รูปถ่ายประจำวัน'),
        Image.asset('images/arch123.jpg'),
        // Text('วันที่'),
        // Text(
        //   '3/4/2563',
        //   style: TextStyle(fontSize: 18.0),
        // ),
      ],
    );
  }

  Widget showPictureHorizontalViewReport() {
    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('รูปถ่ายประจำวัน'),
            Row(
              children: <Widget>[
                Image.asset(
                  'images/arch123.jpg',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.0),
                Image.asset(
                  'images/arch123.jpg',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.0),
                Image.asset(
                  'images/arch123.jpg',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('03 เมษายน 2563'),
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(Icons.delete, color: Colors.white), onPressed: null),
          // IconButton(
          //     icon: Icon(Icons.refresh, color: Colors.white), onPressed: null),
          IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {
                print(
                    'Click option จ้า >>>  จะใช้ตรงนี้เพื่อส่ง notification นะ');
              }),
          SizedBox(
            width: 15.0,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            // showTextSubject('Daily Report : 3/4/2563'),
            // showCoverReport(),
            // SizedBox(height: 10.0),

            showTextTitle('รูปถ่ายประจำวัน', 'add', 18.0, () {
              print('กด รูปถ่ายประจำวัน');
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (BuildContext context) {
                return AddDailyImagePage();
              });
              Navigator.of(context).push(route); // กดย้อนกลับได้
            }),
            // Features(),
            _imageList2(),
            // GridSubject(),
            showTextTitle('รายงานความก้าวหน้า', 'add', 22.0, () {}),
            showProgressDataTable2(),
            SizedBox(height: 18.0),
            showTextTitle('แรงงาน', 'add', 18.0, () {}),
            showStaffDataTable(),
            SizedBox(height: 18.0),
            showTextTitle('แรงงาน', 'add', 18.0, () {}),
            showManpoerDataTable(),
            SizedBox(height: 18.0),
            showTextTitle('วัสดุ', 'add', 18.0, () {}),
            showMaterialDataTable(),
            SizedBox(height: 18.0),
            showTextTitle('เครื่องจักร', 'add', 18.0, () {}),
            showMachineDataTable(),
            // MainGridList(),
            SizedBox(height: 100.0),
            acceptButton(),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
