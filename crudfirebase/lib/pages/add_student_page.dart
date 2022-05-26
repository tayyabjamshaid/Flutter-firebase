import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({ Key? key }) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
 
  var name="";
  var email="";
  var password="";
  final nameController=TextEditingController();
  final emailController=TextEditingController();
 final passwordController=TextEditingController();

 //adding data with firebase
  CollectionReference students=FirebaseFirestore.instance.collection("students");
  Future<void>addUser(){
   return students.add({'name':name,'email':email,'password':password})
  .then((value) => print('RECORD Added')).catchError((error)=>print("Failed to Add User $error"));  }
  clearText(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
  final _formKey=GlobalKey<FormState>();
  @override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Add new Student')),
    body: Form(key:_formKey,child: Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),child: ListView(
      children: [
        Container(margin: EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(controller: nameController,autofocus: false,
        decoration: InputDecoration(labelText: "Name : ",border: OutlineInputBorder(),labelStyle: TextStyle(fontSize: 20),
        errorStyle:TextStyle(fontSize: 20,color:Colors.red)),validator: (String? value) {                        
  if (value==null||value.isEmpty ) {
    return "Name cann't be empty";
  }

  return null;
},),),
 Container(margin: EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(controller: emailController,autofocus: false,
        decoration: InputDecoration(labelText: "Email : ",border: OutlineInputBorder(),labelStyle: TextStyle(fontSize: 20),
        errorStyle:TextStyle(fontSize: 20,color:Colors.red)),validator: (String? value) {                        
  if (value==null||value.isEmpty ) {
    return "Email cann't be empty";
  }else if(!value.contains('@')){
  return 'Should be a Proper Email';
  }

  return null;
},),),
 Container(margin: EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(controller: passwordController,autofocus: false,obscureText: true,
        decoration: InputDecoration(labelText: "Password : ",border: OutlineInputBorder(),labelStyle: TextStyle(fontSize: 20),
        errorStyle:TextStyle(fontSize: 20,color:Colors.red)),validator: (String? value) {                        
  if (value==null||value.isEmpty ) {
    return "Password cann't be empty";
  }

  return null;
},),),
     Container(margin: EdgeInsets.symmetric(vertical: 10.0),child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
ElevatedButton(onPressed: (){
          if(_formKey.currentState!.validate()){
            setState(() {
              name=nameController.text;
               email=emailController.text;
           password=passwordController.text;
           addUser();
           clearText();
            });
          
          }
        }, child: Text("Register",style: TextStyle(fontSize: 18.0)),style:ElevatedButton.styleFrom(primary: Colors.greenAccent) ,),
ElevatedButton(onPressed: ()=>{
  clearText()
}, child: Text("Reset",style: TextStyle(fontSize: 18.0),),style: ElevatedButton.styleFrom(primary: Colors.blueGrey))
     ],),) ],
    ),)),);
  }
}
