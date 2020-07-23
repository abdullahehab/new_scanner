import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:skincancer/model/user.dart';
import 'package:skincancer/ui/listviewuser.dart';
import 'package:skincancer/roundButton.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DoctorInformation extends StatefulWidget {
  final Doctor doctor;
  DoctorInformation(this.doctor);
  @override
  _DoctorInformationState createState() => _DoctorInformationState();
}
final DoctorReferance = FirebaseDatabase.instance.reference().child('user');
class _DoctorInformationState extends State<DoctorInformation> {

final GlobalKey<ScaffoldState> _scaffoldkey= new GlobalKey<ScaffoldState>();

@override
void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title:Text('Doctore Information',
        style: TextStyle(
          color:Colors.grey[400]
        ),
        ),
        backgroundColor: Color.fromRGBO(143, 148, 250, 1),
      ),
      body:SingleChildScrollView(
      child:Center(
        child:Column(
          children: <Widget>[
            
            Text(widget.doctor.id),
            SizedBox(height: 10,),
            Padding(padding: EdgeInsets.only(top:8.0)),
            Text(widget.doctor.DRname),
            Padding(padding: EdgeInsets.only(top:8.0)),
            Text(widget.doctor.DRaddress),
            Padding(padding: EdgeInsets.only(top:8.0)),
            Text(widget.doctor.DRspecialization),
            Padding(padding: EdgeInsets.only(top:8.0)),
            Text(widget.doctor.clinicmobile),
            Padding(padding: EdgeInsets.only(top:8.0)),
           
                    
          ],
          )
      )
      )
    );
  }
}