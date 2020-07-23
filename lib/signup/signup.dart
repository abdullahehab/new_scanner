import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skincancer/components/displayCustomLoader.dart';
import 'package:skincancer/components/showCustomError.dart';
import 'package:skincancer/roundButton.dart';
import '../constants.dart';
import '../welcome_page.dart';
import 'alreadyhaveanaccount.dart';
import 'package:skincancer/siginin/sighin.dart';
import 'social_icon.dart';
import 'or_divider.dart';
import 'package:skincancer/Animation/fadeAnimation.dart';
import 'package:skincancer/utils/user_to_database.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  TextEditingController _emailcontroller = new TextEditingController();
  TextEditingController _passwordcontroller = new TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _validatePhone = false;
  bool _validatePass = false;
  bool showPassword = true;

  changeShowPassword() => setState(() => showPassword = !showPassword);

  bool getShowPassword() => showPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
          Container(
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/image/background.png'),
                fit: BoxFit.fill,
              )),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/light-1.png'))),
                    ),
                  ),
                  Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image/light-2.png'))),
                      )),
                  Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image/clock.png'))),
                      )),
                  Positioned(
                      child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text('Sign UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold)),
                          )))
                ],
              )),
          Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 250, 2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: TextField(
                            controller: _emailcontroller,
                            decoration: InputDecoration(
                                errorText: _validatePhone
                                    ? "Please, Enter Your Email"
                                    : null,
                                border: InputBorder.none,
                                hintText: 'Email or Phone Number',
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            obscureText: showPassword,
                            controller: _passwordcontroller,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () => changeShowPassword(),
                                  color: Theme.of(context).focusColor,
                                  icon: Icon(
                                    showPassword == true
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                errorText: _validatePhone
                                    ? "Please, Enter Your passowrd"
                                    : null,
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        )
                      ])),
                  SizedBox(
                    height: 30,
                  ),
                  RoundedButton(text: "SIGNUP", press: () => formValidation()),
                  SizedBox(height: 30),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return signin();
                          },
                        ),
                      );
                    },
                  ),
                  OrDivider(),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                SocalIcon(
//                  iconSrc: "assets/icons/facebook.svg",
//                  press: () {},
//                ),
//
//                SocalIcon(
//                  iconSrc: "assets/icons/google-plus.svg",
//                  press: () {},
//                ),
//              ],
//            )
                ]),
              ))
        ]))));
  }

  formValidation() {
    setState(() {
      if (_emailcontroller.text.isEmpty && _passwordcontroller.text.isEmpty) {
        setState(() {
          _validatePhone = true;
          _validatePass = true;
        });
      } else if (_emailcontroller.text.isEmpty) {
        setState(() {
          _validatePhone = true;
          _validatePass = false;
        });
      } else if (_passwordcontroller.text.isEmpty) {
        setState(() {
          _validatePhone = false;
          _validatePass = true;
        });
      } else {
        displayCustomCircular(scaffoldKey.currentContext);
        setState(() {
          _validatePhone = false;
          _validatePass = false;
        });

        signIn();
      }
    });
  }

  Future<void> signIn() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailcontroller.text, password: _passwordcontroller.text)
        .then((signedInUser) {
      closeCustomCircular(scaffoldKey.currentContext);
      showSnackBar(
          "User created successfully.", scaffoldKey, context, successColor);


      startTimerForNavigation();

      //TODO : save user data for realtime data base
    }).catchError((e) {
      closeCustomCircular(scaffoldKey.currentContext);
      print("err");
      print(e.message.toString());
      if (e.message.toString() ==
          "There is no user record corresponding to this identifier. The user may have been deleted.") {
        showSnackBar("User Not Found.", scaffoldKey, context, errorColor);
      } else if (e.message.toString() ==
          "A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
        showSnackBar("Please, Check your Internet connection.", scaffoldKey,
            context, errorColor);
      } else {
        showSnackBar(e.message.toString(), scaffoldKey, context, errorColor);
      }
    });
  }

  startTimerForNavigation() async {
    return new Timer(Duration(seconds: 3), navigatorPage);
  }

  void navigatorPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomePagr()));
  }
}
