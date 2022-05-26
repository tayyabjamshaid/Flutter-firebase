import 'package:crudfirebase/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _intialization=Firebase.initializeApp();
  // const MyApp({Key? key}) : super(key: key);
MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future:_intialization,builder: (context,snapshot){
      if(snapshot.hasError){
        print("Something Went Wrong");
      }
      if(snapshot.connectionState==ConnectionState.done){
        return  MaterialApp(
      title: 'Flutter FireStore',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
      }
      return CircularProgressIndicator();
    });
    
    
    
    
  }
}

