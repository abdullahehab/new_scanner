import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class UserToDatabase{


  addNewUser(user,contexxt){
  FirebaseDatabase.instance.reference().child('users').push().set({

  }).then((value){

  }).catchError((e){
    print(e);
  });
  }
}