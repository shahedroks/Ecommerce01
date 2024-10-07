import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http ;
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name= TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void Register () async {
    SharedPreferences profs =await SharedPreferences.getInstance();
    var url = Uri.parse('http://68.178.163.174:5501/user/register');
    Map body = {
      'name': name.text,
      'email':email.text,
      'password':password.text,
      'role':'user'
    };
    http.Response res = await http.post(url, body: body);
    print(res.body);
    print(res.statusCode);
    var decode = jsonDecode(res.body);
    if (res.statusCode == 201){
      Fluttertoast.showToast(
          msg: "Registered Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacementNamed(context, '/');

    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration:BoxDecoration(image: DecorationImage(image: AssetImage('Assets/Background.png'),fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: TextField(controller: name,
                decoration: InputDecoration(hintText: 'Name',
                    labelText: 'Enter Your Name',
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(2)) ),),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

              child: TextField(controller: email,
                decoration: InputDecoration(hintText: 'email',
                    labelText: 'Enter Your Email',
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(2))
                ),),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

              child: TextField(controller: password,
                decoration: InputDecoration(hintText: 'Password',
                  labelText: 'Enter Your Password',
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(2))
              ),),
            ),
            ElevatedButton(onPressed: (){
              Register();
            },style: ElevatedButton.styleFrom(backgroundColor: Colors.red[200]), child: Text('Login',
              style: TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I Want '),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Text('Login...',style: TextStyle(color: Colors.green),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
