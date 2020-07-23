import 'package:firebase_database/firebase_database.dart';




class Doctor{
  String _id;
  String _DRname;
  String _DRaddress;
  String _DRspecialization;
  String _clinicmobile ;


   Doctor(this._id, this._DRname,this._DRaddress,this._DRspecialization,this._clinicmobile);


   Doctor.map(dynamic obj){
     this._id = obj['id'];
     this._DRname = obj['DRname'];
     this._DRaddress= obj['DRaddress'];
     this._DRspecialization = obj['DRspecialization'];
     this._clinicmobile = obj['clinicmobile'];
   }
 
  String get id=>_id;
  String get DRname=> _DRname;
  String get DRaddress=>_DRaddress;
  String get DRspecialization =>_DRspecialization;
  String get clinicmobile =>_clinicmobile;

  Doctor.fromSnapshot(DataSnapshot snapshot){
    _id = snapshot.value['id'];
    _DRname = snapshot.value['DR Name'];
    _DRaddress = snapshot.value['DR Address'];
    _DRspecialization = snapshot.value['DR Specialize'];
    _clinicmobile = snapshot.value['Clnic Number'];

  }
}