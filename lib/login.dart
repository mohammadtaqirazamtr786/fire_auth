import 'package:achievement_view/achievement_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepr202210e/home.dart';
import 'package:firebasepr202210e/signup.dart';
import 'package:flutter/material.dart';

import 'input.dart';
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final email1=TextEditingController();
  final password=TextEditingController();
  void UserSignIn() async
  {
    try
        {
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email1.text.toString(), password: password.text.toString());
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(),));
          AchievementView(
              title: "Login Successfully",
              icon: Icon(Icons.person,color: Colors.green,),
              color: Colors.green
          ).show(context);
        }
       on FirebaseAuthException catch(e)
    {
      AchievementView(
          title: "Error",
          subTitle: "${e.code.toString()}",
          icon: Icon(Icons.dangerous  ,color: Colors.white,),
          color: Colors.red
      ).show(context);
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
              Text('Login',style: TextStyle(
                fontSize: 40,
                color: Colors.purple
              ),),
              SizedBox(height: 40,),
              input(controller1: email1,hintText1: "Enter your email",lable1: "Email",obs1: false),
              SizedBox(height: 30,),
              input(controller1: password,hintText1: "Enter your password",lable1: "Password",obs1: true,),
              SizedBox(height: 40,),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (){
                        UserSignIn();
                      }, child: Text('Login',style: TextStyle(
                    fontSize: 25,
                    color: Colors.pink
                  ),))),
              SizedBox(height: 30,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => signUp(),));
              }, child: Text("Register Account?Sign Up"))

            ],
          ),
        ),
      ),
    );
  }
}


