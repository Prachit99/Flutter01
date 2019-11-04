import 'package:flutter/material.dart';
import 'login.dart';
void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
    Widget build(BuildContext context){
      return new MaterialApp(
        title: 'Sign in page',
        theme: new ThemeData(
          primarySwatch: Colors.blue
        ),
        home: new LoginPage()
      );
    }
}