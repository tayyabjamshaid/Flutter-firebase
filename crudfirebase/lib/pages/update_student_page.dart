import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class UpdateStudentPage extends StatefulWidget {
  final String id;
   const UpdateStudentPage({ Key? key,required this.id }) : super(key: key);
   
  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  //updating data
    CollectionReference students=FirebaseFirestore.instance.collection("students");
    Future<void> updateUser(id,name,email,password){
   return students.doc(id).update({'name':name,'email':email,'password':password})
  .then((value) => print('RECORD Updated')).catchError((error)=>print("Failed to Update User $error"));  }
  final _formKey=GlobalKey<FormState>();
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Update User Data")),

    body:Form(key: _formKey,child:
    //getting specific data by id
    FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>
    (future: FirebaseFirestore.instance.collection('students').doc(widget.id).get(),builder: (_,snapshot){
      if(snapshot.hasError){
        print("Something Went Wrong");
      }
      if(snapshot.connectionState==ConnectionState.waiting){
     return Center(child: CircularProgressIndicator());
      }
      var data=snapshot.data!.data();
      var name=data!['name'];
       var email=data['email'];
        var password=data['password'];
        return
         Padding(padding:EdgeInsets.symmetric(vertical: 10,horizontal: 30),child: ListView(children: [
    Container(margin: EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(autofocus: false,initialValue: name,onChanged: (value)=>name=value,
        decoration: InputDecoration(labelText: "Name : ",border: OutlineInputBorder(),labelStyle: TextStyle(fontSize: 20),
        errorStyle:TextStyle(fontSize: 20,color:Colors.red)),validator: (String? value) {                        
  if (value==null||value.isEmpty ) {
    return "Please Enter Name";
  }

  return null;
},),),
Container(margin: EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(autofocus: false,onChanged: (value)=>email=value,initialValue: email,
        decoration: InputDecoration(labelText: "Email : ",border: OutlineInputBorder(),labelStyle: TextStyle(fontSize: 20),
        errorStyle:TextStyle(fontSize: 20,color:Colors.red)),validator: (String? value) {                        
  if (value==null||value.isEmpty ) {
    return "Please Enter Email";
  }else if(!value.contains('@')){
  return 'Should be a Proper Email';
  }

  return null;
},),),
 Container(margin: EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(autofocus: false,obscureText: true,initialValue: password,onChanged: (value)=>password=value,
        decoration: InputDecoration(labelText: "Password : ",border: OutlineInputBorder(),labelStyle: TextStyle(fontSize: 20),
        errorStyle:TextStyle(fontSize: 20,color:Colors.red)),validator: (String? value) {                        
  if (value==null||value.isEmpty ) {
    return "Please Enter Password";
  }

  return null;
},),),

Container(margin: EdgeInsets.symmetric(vertical: 10.0),child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
ElevatedButton(onPressed: (){
          if(_formKey.currentState!.validate()){
           updateUser(widget.id,name,email,password);
           Navigator.pop(context);
          }
        }, child: Text("Update",style: TextStyle(fontSize: 18.0)),style:ElevatedButton.styleFrom(primary: Colors.greenAccent) ,),
ElevatedButton(onPressed: ()=>{
 
}, child: Text("Reset",style: TextStyle(fontSize: 18.0),),style: ElevatedButton.styleFrom(primary: Colors.blueGrey))]))

    ],)
    );

    },)

   , ) ,);
  }
}