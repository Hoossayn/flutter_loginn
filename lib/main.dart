import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:developer';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "title",
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var c_username = TextEditingController();
  var c_passwrod = TextEditingController();

  _showdialog(String msg){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Info"),
        content: Text(msg),
      );
    });
  }

  loginuser() async{

    http.post("https://Jsonplaceholder.typicode.com/users", body: {
      "username": c_username.text,
      "password": c_passwrod.text,
    }).then((http.Response response){
      var result = jsonDecode(response.body);

      var statusCode = response.statusCode;

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response status: ${response.body}');

      log('status: ${response.statusCode}');
      log('status: ${response.body}');

      if(statusCode < 200 || statusCode >= 300 || response.body == null) {
        _showdialog("Error while login");
      }else{
        _showdialog("Hey It's Loggedin");
      }

      /*if(result['message']){
        _showdialog("Hey It's Loggedin");
      }else{
        _showdialog("Failed To Login");
      }*/
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Login"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: c_username,
              decoration: InputDecoration(
                  hintText: "Enter Your Username",
                  labelText: "Username"
              ),


            ),
            TextField(
              controller: c_passwrod,

              decoration: InputDecoration(

                  hintText: "Enter Your Password",
                  labelText: "Password"
              ),
            ),
            FlatButton(
                color: Colors.blue,
                onPressed: ()=>{ loginuser()
                }, child: Text("Login", style: TextStyle(color: Colors.white),)),

          ],
        ),
      ),
    );
  }
}