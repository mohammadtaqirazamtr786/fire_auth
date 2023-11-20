import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepr202210e/home.dart';
import 'package:firebasepr202210e/login.dart';
import 'package:flutter/material.dart';
class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirebaseAuth.instance.currentUser!=null?home():login(),)));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Spalsh Screen',style: TextStyle(
            color: Colors.purple,
            fontSize: 25
          ),),
        ),
      ),
    );
  }
}
