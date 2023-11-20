import 'package:flutter/material.dart';
class input extends StatelessWidget {
  String lable1;
  String hintText1;
  bool obs1;
  TextEditingController controller1;

  input({required this.lable1, required this.hintText1, required this.obs1, required this.controller1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obs1,
      obscuringCharacter: "*",
      controller: controller1,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('$lable1'),
        hintText: "$hintText1",
      ),
    );
  }
}