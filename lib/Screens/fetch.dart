import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasepr202210e/Screens/edit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class fetch extends StatefulWidget {
  const fetch({super.key});

  @override
  State<fetch> createState() => _fetchState();
}

class _fetchState extends State<fetch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('students').snapshots(),
          builder: (context, snapshot) {
            if(ConnectionState.waiting==snapshot.connectionState)
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            if(snapshot.hasError)
              {
                return Center(
                  child: Text('There has some error!'),
                );
              }
            if(snapshot.hasData)
              {
                var data_length=snapshot.data!.docs.length;
                return Container(
                  child: ListView.builder(
                    itemCount: data_length,
                    itemBuilder: (context, index) {
                      String fullname1=snapshot.data!.docs[index]['fullName'];
                      String country1=snapshot.data!.docs[index]['country'];
                      String gender1=snapshot.data!.docs[index]['gender'];
                      String phone1=snapshot.data!.docs[index]['phone'];
                      var id1=snapshot.data!.docs[index].id;

                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$fullname1'),
                                Text('$country1'),
                                Text('$gender1'),
                                Text('$phone1'),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      title: 'Data Delete',
                                      desc: 'Are you sure...........',
                                      btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                  FirebaseFirestore.instance.collection('students').doc(id1).delete();
                                  },
                                  )..show();

                                }, icon: Icon(Icons.delete,color: Colors.red,)),
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => edit(fn: fullname1, p: phone1, g: gender1, c: country1,id: id1),));
                                }, icon: Icon(Icons.edit,color: Colors.teal,)),
                              ],
                            )
                            ,
                          ),
                        ],
                      ),
                    );
                  },),
                );
              }
            return Container();
          },
        ),
      ),
    );
  }
}
