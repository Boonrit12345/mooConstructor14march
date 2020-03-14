import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mooconstructor14march/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// Field

// Method
  Widget registerButton() {
    return Container(
      width: 250.0,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          'New Register',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        color: MyStyle().primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget userForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: MyStyle().lightColor,
      ),
      height: 35.0,
      width: 250.0,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: MyStyle().h3Style,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: MyStyle().h3Style,
            hintText: 'User :',
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
        borderRadius: BorderRadius.circular(12.0),
        color: MyStyle().lightColor,
      ),
      height: 35.0,
      width: 250.0,
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.text,
        style: MyStyle().h3Style,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: MyStyle().h3Style,
            hintText: 'Password :',
            prefixIcon: Icon(
              Icons.vpn_lock,
              color: MyStyle().darkColor,
            )),
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Moo Constructor',
      style: GoogleFonts.righteous(
        textStyle: MyStyle().h1Style,
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logoblack.png'),
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      height: 15.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              // mySizeBox(),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }
}
