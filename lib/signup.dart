import 'package:achievement_view/achievement_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'input.dart';
import 'login.dart';
class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final email1=TextEditingController();
  final pass1=TextEditingController();
  void signUpUser()async
  {
    try
        {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email1.text.toString(), password: pass1.text.toString());
          AchievementView(
            title: "User Register Successfully!",
            icon: Icon(Icons.ac_unit_sharp),
            color: Colors.green
          ).show(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => login(),));
        }
     on FirebaseAuthException catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code.toString())));

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign Up',style: TextStyle(
                  fontSize: 40,
                  color: Colors.purple
              ),),
              SizedBox(height: 40,),
              input(controller1: email1,hintText1: "Enter your email",lable1: "Email",obs1: false),
              SizedBox(height: 30,),
              input(controller1: pass1,hintText1: "Enter your password",lable1: "Password",obs1: true,),
              SizedBox(height: 40,),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (){
                        signUpUser();
                      }, child: Text('Sign Up',style: TextStyle(
                      fontSize: 25,
                      color: Colors.pink
                  ),))),
              SizedBox(height: 30,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => login(),));
              }, child: Text("Already Account?Login"))
            ],
          ),
        ),
      ),
    );
  }
}
