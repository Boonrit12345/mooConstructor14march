import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mooconstructor14march/copy_example/flutter_draw.dart';
import 'package:mooconstructor14march/copy_example/painter211.dart';
import 'package:mooconstructor14march/example/dashboard.dart';
import 'package:mooconstructor14march/utility/my_style.dart';
import 'package:mooconstructor14march/utility/normal_dialog.dart';
import 'package:mooconstructor14march/widget/my_service.dart';
import 'package:mooconstructor14march/widget/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// Field
  bool status = true;
  String user, password;

// Method
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    if (firebaseUser != null) {
      routeToMyService();
    } else {
      setState(() {
        status = false;
      });
    }
  }

  void routeToMyService() {
    MaterialPageRoute route =
        // MaterialPageRoute(builder: (value) => MyService());
        MaterialPageRoute(builder: (value) => PainterPage());
        

    Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  }

  Widget registerButton() {
    return Container(
      width: 250.0,
      child: FlatButton(
        onPressed: () {
          print('Click register');

          MaterialPageRoute route =
              MaterialPageRoute(builder: (BuildContext context) {
            return Register();
          });
          Navigator.of(context).push(route);
        },
        child: Text(
          'New Register',
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 280.0,
      height: 45.0,
      child: RaisedButton(
        color: MyStyle().primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, "Have space", 'Please fill every blank');
          } else {
            checkAuthen();
          }
        },
      ),
    );
  }

  // ตรวจสอบว่าSign in ถูกต้องหรือไม่
  Future<void> checkAuthen() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth
        .signInWithEmailAndPassword(email: user, password: password)
        .then((value) {
            routeToMyService(); // กรณี sign in ถูกต้อง
        })
        .catchError((value) {
          String title = value.code;
          String message = value.message;
          // normalDialog(context, title, message);
          if (title == 'ERROR_INVALID_EMAIL') {
            normalDialog(context, 'User!', 'กรุณากรอกอีเมลล์ใหม่ให้ถูกต้อง!');
          } else {if (title == 'ERROR_USER_NOT_FOUND') {
            normalDialog(context, 'User!', 'กรุณากรอก user ที่ถูกต้อง!');
          } else {if (title == 'ERROR_WRONG_PASSWORD') {
            normalDialog(context, 'Password!', 'กรุณากรอก Password ที่ถูกต้อง!');
          } else {
            normalDialog(context, title, message);
          }
          }

          }
        });
  }

  Widget userForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      height: 45.0,
      width: 280.0,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        keyboardType: TextInputType.emailAddress,
        style: MyStyle().h3Style,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: MyStyle().h3Style,
            hintText: 'User',
            prefixIcon: Icon(
              Icons.email,
              color: MyStyle().darkColor,
            )),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      height: 45.0,
      width: 280.0,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        keyboardType: TextInputType.text,
        style: MyStyle().h3Style,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: MyStyle().h3Style,
            hintText: 'Password',
            prefixIcon: Icon(
              Icons.vpn_key,
              color: MyStyle().darkColor,
            )),
      ),
    );
  }

  // ชื่อของแอฟ
  Widget showAppName() {
    return Text(
      'Construction App.',
      // style: GoogleFonts.righteous(
        // เรียกใช้ ฟอนต์ จากเว็บ Google เพิ่มฟอนต์ลงในแอฟ ไม่ติดลิขสิทธิ์
        style: GoogleFonts.varelaRound(
        textStyle: MyStyle().h0Style,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // โชว์ Logo 
  Widget showLogo() {
    return Container(
      width: 220.0,
      child: Image.asset('images/DEMOO.png'),
    );
  }

  // สำหรับไว้คั้น Widget ใน Listview
  Widget mySizeBox() {
    return SizedBox(
      height: 25.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status ? showProcess() : mainContent(),
    );
  }


  // กรณีที่เปิดแอฟมาแล้วให้หยุดรอ โดยแสดงวงหลมหมุนๆ ก่อน
  Widget showProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Container mainContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1.0,
          colors: <Color>[
            Colors.white,
            MyStyle().primaryColor,
          ],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showLogo(),
              mySizeBox(),
              showAppName(),
              mySizeBox(),
              userForm(),
              mySizeBox(),
              passwordForm(),
              mySizeBox(),
              loginButton(),
              mySizeBox(),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }
}
