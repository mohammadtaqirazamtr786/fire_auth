import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasepr202210e/Screens/add_data.dart';
import 'package:firebasepr202210e/Screens/product_fetch.dart';
import 'package:firebasepr202210e/input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class product_add extends StatefulWidget {
  const product_add({super.key});

  @override
  State<product_add> createState() => _product_addState();
}

class _product_addState extends State<product_add> {
  final p_name=TextEditingController();
  final p_price=TextEditingController();
  File? selectedImage;
  String select_category='Category1';

  Future productAdd() async
  {
    UploadTask uploadTask=FirebaseStorage.instance.ref().child('Product').putFile(selectedImage!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String downloadUrl=await taskSnapshot.ref.getDownloadURL();
    addData(imageUrl: downloadUrl);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Date Insert')));
    Navigator.push(context, MaterialPageRoute(builder: (context) => product_fetch(),));

  }
  void addData({String? imageUrl}) async
  {
    Map<String,dynamic> map2={
      'product_name':p_name.text.toString(),
      'product_price':p_price.text.toString(),
      'product_category':select_category.toString(),
      "product_image": imageUrl
    };
    await FirebaseFirestore.instance.collection('products').add(map2);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async{
                XFile? slectedFile=await ImagePicker().pickImage(source: ImageSource.gallery);
                if(slectedFile!=null)
                  {
                    File covertedFile=File(slectedFile.path);
                    setState(() {
                      selectedImage=covertedFile;
                    });
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No Image Selected')));
                  }
              },
              child: CircleAvatar(
                backgroundImage: selectedImage!=null?FileImage(selectedImage!):null,
                radius: 120,
                backgroundColor: Colors.purple,
              ),
            ),
            SizedBox(height: 10,),
            input(lable1: 'Product Name', hintText1: "Enter your product name", obs1: false, controller1: p_name),
            SizedBox(height: 10,),
            input(lable1: 'Product Name', hintText1: "Enter your product name", obs1: false, controller1: p_price),
            SizedBox(height: 10,),
            Container(
              child: Center(
                child: DropdownButtonFormField(
                  value: select_category,
                  onChanged: (newValue)
                  {
                    setState(() {
                      select_category=newValue!;
                    });
                  },
                  items: ['Category1','Category2','Category3','Category4'].map((String value){
                    return DropdownMenuItem(child: Text('$value'),value: value,);
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(onPressed: (){
                  productAdd();
                }, child: Text('Product Add')))

          ],
        ),
      ),
    );
  }
}
