import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepr202210e/login.dart';
import 'package:flutter/material.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.purple,
       actions: [
         GestureDetector(
           onTap: () async{
             await FirebaseAuth.instance.signOut();
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Logout')));
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login(),));

           },
           child: Container(
               padding: EdgeInsets.only(right: 20),
               child: Icon(Icons.logout,color: Colors.white,)),
         )
       ],
       
     ),
      body: Text('Home'),
    );
  }
}
