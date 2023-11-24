import 'package:achievement_view/achievement_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../input.dart';
class edit extends StatefulWidget {
  String fn;
  String p;
  String g;
  String c;
  String id;

  edit({required this.fn,required this.p,required this.g,required this.c,required this.id});

  @override
  State<edit> createState() => _editState(fn1: fn,p1: p,g1: g,c1: c,id5: id);
}

class _editState extends State<edit> {
  String fn1;
  String p1;
  String g1;
  String c1;
  String id5;

  _editState({required this.fn1,required this.p1,required this.g1,required this.c1,required this.id5});

  final fullname1=TextEditingController();
  final phone1=TextEditingController();
  final country1=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullname1.text=widget.fn;
    phone1.text=widget.p;
    country1.text=widget.c;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Edit Data',style: TextStyle(
                    fontSize: 30,
                    color: Colors.purple
                ),),
                SizedBox(height: 30,),
                input(lable1: 'Full Name', hintText1: "Enter your fullname", obs1: false, controller1: fullname1),
                SizedBox(height: 20,),
                Center(
                  child: DropdownButtonFormField<String>
                    (
                    value: g1,
                    onChanged: (newValue)
                    {
                      setState(() {
                        g1=newValue!;
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
                input(lable1: 'Phone', hintText1: "Enter your phone", obs1: false, controller1: phone1),
                SizedBox(height: 20,),
                input(lable1: 'Country', hintText1: "Enter your country", obs1: false, controller1: country1),
                SizedBox(height: 40,),
                Container(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(onPressed: (){
                      Map<String,dynamic> map2={
                        "country":country1.text.toString(),
                        "fullName":fullname1.text.toString(),
                        "phone":phone1.text.toString(),
                        "gender":g1
                      };
                      FirebaseFirestore.instance.collection('students').doc(id5).update(map2);
                      AchievementView(
                        title: "Data Update Successfully",
                        color: Colors.green
                      ).show(context);
                      Navigator.pop(context);


                    }, child: Text("Edit Data"))),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
