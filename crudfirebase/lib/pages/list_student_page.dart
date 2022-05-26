import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfirebase/pages/update_student_page.dart';
import 'package:flutter/material.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({ Key? key }) : super(key: key);

  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  //connect it with firebase
  final Stream<QuerySnapshot> studentsStream=FirebaseFirestore.instance.collection('students').snapshots();
  //DEleteing data
  CollectionReference students=FirebaseFirestore.instance.collection("students");
  Future<void> deleteUser(id){
    return students.doc(id).delete().then((value) => print('RECORD DELETED')).catchError((error)=>print("Failed to Delete User $error"));  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream:studentsStream,builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
      if(snapshot.hasError){
        print("Something Went Wrong");
      }
      if(snapshot.connectionState==ConnectionState.waiting){
     return Center(child: CircularProgressIndicator());
      }
      //Read Data
      final List storedocs=[];
      snapshot.data!.docs.map((DocumentSnapshot document){
       Map a =document.data() as Map<String,dynamic>;
        a['id']=document.id;
       storedocs.add(a);
      
      }).toList();
      return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
      child: SingleChildScrollView(scrollDirection: Axis.vertical,
      child: Table(border: TableBorder.all(),columnWidths: const <int,TableColumnWidth>{
        1:FixedColumnWidth(140)
      },defaultVerticalAlignment: TableCellVerticalAlignment.middle, //By this property,our table text will be in center
      children: [
        TableRow(children: [TableCell(child:Container(    //Name Data
          color: Colors.greenAccent,child: Center(child: Text('Name',style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),)),
        )),TableCell(child:Container( //Email Data
          color: Colors.greenAccent,child: Center(child: Text('Email',style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),)),
        )),TableCell(child:Container( //Action Data
          color: Colors.greenAccent,child: Center(child: Text('Action',style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),)),
        ))]),
        for (var i = 0; i < storedocs.length; i++) ...[
         TableRow(children: [TableCell(child:Center(child:  Text(storedocs[i]['name'],style: TextStyle(fontSize: 18.0),),),),
         TableCell(child: Center(child:  Text(storedocs[i]['email'],style: TextStyle(fontSize: 18.0),)),),
         TableCell(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
           IconButton(onPressed: ()=>{
             Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateStudentPage(id:storedocs[i]['id'])))
           }, icon: Icon(Icons.edit,color:Colors.orange)),
           IconButton(onPressed: ()=>{
             deleteUser(storedocs[i]['id'])
           }, icon: Icon(Icons.delete,color:Colors.red))
         ],),)])
      ],]),),
    );
    });
    
  }
}