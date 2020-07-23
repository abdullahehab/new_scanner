import 'package:flutter/material.dart';
import 'package:skincancer/ui/doctorinformation.dart';
import 'package:skincancer/roundButton.dart';
import 'package:skincancer/siginin/sighin.dart';
import 'package:skincancer/signup/signup.dart';
import 'package:skincancer/ui/listviewuser.dart';
import 'package:skincancer/ui/userscreen.dart';
import 'package:skincancer/model/user.dart';
class welcomescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: Column(
        children:<Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration:BoxDecoration(
                image:DecorationImage(
                  image:AssetImage('assets/image/d.jpg'),
                  fit: BoxFit.cover
                   )
              )
            ),
            ),
            Expanded(
              child: Column(
                children:<Widget>[
                  SizedBox(
                height: 30,
                  ),
           RoundedButton(
                 text:"LOGIN",
                 press:(){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return  signin()
                      //listviewscreen()
                    // Doctorescreen(Doctor(null, '', '', '', ''))
                     ;
                    },
                  ),
                );
                 }
               ),
              SizedBox(
                 height:10
               ),
               RoundedButton(
                 text:'SIGN UP',
                 press:(){
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return homepage();
                    },
                  ),
                );
                 }
               )
                ]
              )
              )
        ]
      ),
    );
  }
}