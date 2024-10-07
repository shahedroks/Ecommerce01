import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseConnecting extends StatefulWidget {
  const FirebaseConnecting({super.key});

  @override
  State<FirebaseConnecting> createState() => _FirebaseConnectingState();
}

class _FirebaseConnectingState extends State<FirebaseConnecting> {
  FirebaseFirestore fire = FirebaseFirestore.instance;

List data =[];
  void GetData ()async{


try{
  var snapshorts = await fire.collection('user').get();
  setState(() {
    data = snapshorts.docs;
  });


}catch(err){
  print('error getdata');

}
  }
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase'),
      ),
      body: Column(
        children: data.map((i){
          return Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(color: Colors.green),
            child: Text('${i['post']}'),
          );

        }).toList(),
      ),
    );
  }
}
