import 'package:achievement_view/achievement_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasepr202210e/Screens/fetch.dart';
import 'package:firebasepr202210e/input.dart';
import 'package:flutter/material.dart';
class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  final fullname=TextEditingController();
  final country=TextEditingController();
  final phone=TextEditingController();
  String selectedGender='Male';
  void addData() async
  {
    try
        {
          Map<String,dynamic> data1={
            "fullName":fullname.text.toString(),
            "country":country.text.toString(),
            "phone":phone.text.toString(),
            "gender":selectedGender
          };

          await FirebaseFirestore.instance.collection('students').add(data1);
          fullname.clear();
          country.clear();
          phone.clear();
          AchievementView(
              title:"Data Insert Successfully",
              icon: Icon(Icons.emoji_emotions_outlined),
              color: Colors.green
          ).show(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => fetch(),));

        }
      on FirebaseException catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.code.toString()}')));

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add Data',style: TextStyle(
                  fontSize: 30,
                  color: Colors.purple
                ),),
                SizedBox(height: 30,),
                input(lable1: 'Full Name', hintText1: "Enter your fullname", obs1: false, controller1: fullname),
                SizedBox(height: 20,),
                Center(
                  child: DropdownButtonFormField<String>
                    (
                    value: selectedGender,
                    onChanged: (newValue)
                    {
                      setState(() {
                        selectedGender=newValue!;
                      });
                    },
                    items:<String>['Male','Female','Others'].map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      label: Text('Select Gender'),
                      border: OutlineInputBorder()
                    ),

                  ),
                ),
                SizedBox(height: 20,),
                input(lable1: 'Phone', hintText1: "Enter your phone", obs1: false, controller1: phone),
                SizedBox(height: 20,),
                input(lable1: 'Country', hintText1: "Enter your country", obs1: false, controller1: country),
                SizedBox(height: 40,),
                Container(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(onPressed: (){
                      addData();
                    }, child: Text("Add Data"))),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
