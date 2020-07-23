import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:skincancer/model/user.dart';
import 'package:skincancer/ui/userscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skincancer/ui/doctorinformation.dart';


class listviewscreen extends StatefulWidget{
  @override
  _listviewuserstate createState() => new  _listviewuserstate();

}

final doctorReferance = FirebaseDatabase.instance.reference().child('user');

final GlobalKey<ScaffoldState> _scaffoldkey= new GlobalKey<ScaffoldState>();



class _listviewuserstate extends State< listviewscreen> {
  List<Doctor>items;
  StreamSubscription<Event>_ondoctoraddedSubscription;
  StreamSubscription<Event>_ondoctorchangedSubscription;
  final key =  _scaffoldkey;
 @override
   void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _ondoctoraddedSubscription = doctorReferance.onChildAdded.listen(_ondoctoradded);
    _ondoctorchangedSubscription = doctorReferance.onChildAdded.listen(_ondoctorupdated);
  }

  @override
  void dispose (){
  super.dispose();
  _ondoctoraddedSubscription.cancel();
  _ondoctorchangedSubscription .cancel();
  }
  @override
  Widget build(BuildContext context){
  return MaterialApp(
    title: 'user DB',
    home:Scaffold(
      appBar: AppBar(
        title:Text('User Information') ,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(143, 148, 250, 1),
        ),
        body: Center(
          child: ListView.builder(
            itemBuilder: (context, position){
              return Column(
            children: <Widget>[
              Divider(
                height:6
              ),
              Row(
                children: <Widget>[
             Expanded(
               child:  ListTile(
                title:Text(
                  '${items[position].DRname}',style: TextStyle(
                  color:Colors.black,
                  fontSize: 22.0
                ),
                ),
              subtitle: Text(
                
                  '${items[position].DRaddress}',style: TextStyle(
                  color:Colors.black,
                  fontSize: 14.0
                ),
                ),
                leading: Column(
                  children:<Widget>[
                    CircleAvatar(
                      backgroundColor: Color.fromRGBO(143, 148, 250, 1),
                      radius: 18.0,
                      child: Text('${position+1}',
                        style: TextStyle(
                          color:Colors.black,
                          fontSize:14.0
                        ),
                      ),
                    ),
                    
                
                  ]
                ),
                onTap: ()=> _navigatetodoctorinformation(context,items[position]),
                
              ),),
              IconButton(
                      icon: Icon(Icons.delete), 
                      color: Colors.red,
                    onPressed: ()=>
                      _deletdoctor(context,items[position],position)
                    
                    ),
                     IconButton(
                      icon: Icon(Icons.edit), 
                      color: Color.fromRGBO(143, 148, 250, 1),
                    onPressed: ()=>
                      _navigatetodoctor(context,items[position])
                    
                    ),

                ],
              ),
              
            ],
              );
            },
            itemCount: items.length,
            padding: EdgeInsets.only(top:12.0),

            )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:()=>_creatnewdector(context) ,
          child: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Color.fromRGBO(143, 148, 250, 1),
        ),
    ),
  );
  }
  void _ondoctoradded (Event event){
   setState(() {
     items.add(new Doctor.fromSnapshot(event.snapshot));
   });
  }
  void _ondoctorupdated(Event event){
    var olddoctorvalue= items.singleWhere((doctor)=>doctor.id == event.snapshot.key);
   
  
    setState(() {
     items[items.indexOf(olddoctorvalue)] = new Doctor.fromSnapshot(event.snapshot);
   });
  }
  void _deletdoctor(BuildContext context,Doctor doctor,int position) async{
 await doctorReferance.child(doctor.id).remove().then((_){
   setState((){
items.removeAt(position);
   });
 });
  }
  void _navigatetodoctor(BuildContext context, Doctor doctor) async{

await Navigator.push(context, 
MaterialPageRoute(builder: (context)=> Doctorescreen(doctor)),
);
  }
  void _creatnewdector(BuildContext context)async{
//toastmassage();
//_ShowSnakebar();

await Navigator.push(context, 
MaterialPageRoute(builder: (context)=> Doctorescreen(Doctor(null, '', '', '', ''))),
);
  }


  _ShowSnakebar(){
   print('show snack bar here');
  _scaffoldkey.currentState.showSnackBar(SnackBar(
    content: Text('Doctor added '),
    duration: Duration(seconds:5),
    backgroundColor: Color.fromRGBO(143, 148, 250, 1),
    action: SnackBarAction(label: 'ok',onPressed: (){
      print('ok');
    },),
  ));                    
  }


toastmassage(){
  Fluttertoast.showToast(
    msg: 'Doctor Added Successfull',
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Color.fromRGBO(143, 148, 250, 1),
    textColor: Colors.white,
    fontSize: 10.0,
    gravity: ToastGravity.CENTER
    );
}

void _navigatetodoctorinformation(BuildContext context, Doctor doctor) async{

await Navigator.push(context, 
MaterialPageRoute(builder: (context)=> DoctorInformation(doctor)),
);
  }
}