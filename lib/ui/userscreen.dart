import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:skincancer/model/user.dart';
import 'package:skincancer/ui/listviewuser.dart';
import 'package:skincancer/roundButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Doctorescreen extends StatefulWidget {
  final Doctor doctor;
  Doctorescreen(this.doctor);
  @override
  _DoctorescreenState createState() => _DoctorescreenState();
}
final DoctorReferance = FirebaseDatabase.instance.reference().child('user');
class _DoctorescreenState extends State<Doctorescreen> {

final GlobalKey<ScaffoldState> _scaffoldkey= new GlobalKey<ScaffoldState>();


TextEditingController _idcontroller;
TextEditingController _drnamecontroller;
TextEditingController _draddresscontroller;
TextEditingController _drspecializecontroller;
TextEditingController _clincmobilecontroller;





@override
void initState() {
    // TODO: implement initState
    super.initState();
 _idcontroller = new TextEditingController(text:widget.doctor.id);
 _drnamecontroller = new TextEditingController(text:widget.doctor.DRname);
 _draddresscontroller = new TextEditingController(text:widget.doctor.DRaddress);
 _drspecializecontroller = new TextEditingController(text:widget.doctor.DRspecialization);
 _clincmobilecontroller = new TextEditingController(text:widget.doctor.clinicmobile);
  }
void main(List<String> args) {
  print(_idcontroller);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title:Text('Add Doctore '),
        backgroundColor: Color.fromRGBO(143, 148, 250, 1),
      ),
      body:SingleChildScrollView(
      child: Container(
        margin:EdgeInsets.only(top:15.0),
        alignment:Alignment.center,
        child:Column(
          children: <Widget>[
            Container(
                       padding:EdgeInsets.all(8.0) ,
                       child: TextField(
                         controller: _idcontroller,
                         decoration: InputDecoration(
                           icon: Icon(
                             Icons.vpn_key
                           ),
                           border:InputBorder.none,
                           hintText:'id',
                           hintStyle:TextStyle(color:Colors.grey[400])
                         ),
                       ),
                       ),
                      SizedBox(
                  height:10,
                ),
                Container(
                       padding:EdgeInsets.all(8.0) ,
                       child: TextField(
                         controller: _drnamecontroller,
                         decoration: InputDecoration(
                           icon: Icon(
                             Icons.people
                           ),
                           border:InputBorder.none,
                           hintText:'DR Name',
                           hintStyle:TextStyle(color:Colors.grey[400])
                         ),
                       ),
                       ),
                      SizedBox(
                  height:10,
                ),
                Container(
                       padding:EdgeInsets.all(8.0) ,
                       child: TextField(
                         controller: _draddresscontroller,
                         decoration: InputDecoration(
                           icon: Icon(
                             Icons.place
                           ),
                           border:InputBorder.none,
                           hintText:'DR Address',
                           hintStyle:TextStyle(color:Colors.grey[400])
                         ),
                       ),
                       ),
                      SizedBox(
                  height:10,
                ),
                Container(
                       padding:EdgeInsets.all(8.0) ,
                       child: TextField(
                         controller: _drspecializecontroller,
                         decoration: InputDecoration(
                           icon: Icon(
                             Icons.vpn_key
                           ),
                           border:InputBorder.none,
                           hintText:'DRSpecialize',
                           hintStyle:TextStyle(color:Colors.grey[400])
                         ),
                       ),
                       ),
                    
                      SizedBox(
                  height:10,
                ),
                Container(
                       padding:EdgeInsets.all(8.0) ,
                       child: TextField(
                         
                         controller: _clincmobilecontroller,
                        
                         decoration: InputDecoration(
                           
                           icon: Icon(
                             Icons.mobile_screen_share
                           ),
                           border:InputBorder.none,
                           hintText:'Clinic Number',
                           hintStyle:TextStyle(color:Colors.grey[400])
                         ),
                       ),
                       ),
                      SizedBox(
                  height:10,
                ),
                FlatButton(
                  color: Color.fromRGBO(143, 148, 250, 1),

                  onPressed: (){
                    if(widget.doctor.id !=null){
                      doctorReferance.child(widget.doctor.id).set({
                         'id': _idcontroller.text,
                        'DR Name': _drnamecontroller.text,
                        'DR Address':_draddresscontroller.text,
                        'DR Specialize':_drspecializecontroller.text,
                        'Clnic Number':_clincmobilecontroller.text,
                      }).then((_){
                        Fluttertoast.showToast(
                          msg: 'Update Successful',
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Color.fromRGBO(143, 148, 250, 1),
                          textColor: Colors.white,
                          fontSize: 15.0,
                          gravity: ToastGravity.BOTTOM
                          );
                 Navigator.pop(context);
                      });
                    } else{
                      doctorReferance.push().set({
                        'id': _idcontroller.text,
                        'DR Name': _drnamecontroller.text,
                        'DR Address':_draddresscontroller.text,
                        'DR Specialize':_drspecializecontroller.text,
                        'Clnic Number':_clincmobilecontroller.text,
                      }).then((_) {
                         Fluttertoast.showToast(
                         msg: 'Doctor Added Successfull',
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Color.fromRGBO(143, 148, 250, 1),
                        textColor: Colors.white,
                        fontSize: 15.0,
                        gravity: ToastGravity.BOTTOM
                         );
                  
                      });
                    }
                  },
                 
                  child: (widget.doctor.id != null)?Text('Update'):Text('Add')
                   )
          ],
          )
      ),
      )
    );
  }
}