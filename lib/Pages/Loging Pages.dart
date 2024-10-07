import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Logingpage extends StatefulWidget {
   Logingpage({super.key});

  @override
  State<Logingpage> createState() => _LogingpageState();
}

class _LogingpageState extends State<Logingpage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController otp = TextEditingController();
  var riceveid ;
  var otpsend = false;



  void goToDashbord (role){
    switch(role){
      case 'user':
        Navigator.pushReplacementNamed(context, '/userpage');
        Fluttertoast.showToast(
            msg: "Login User ID",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        break;
      case 'admin':
        Navigator.pushReplacementNamed(context, '/adminpage');
        Fluttertoast.showToast(
            msg: "Login Admin ID",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
    }
  }
  void Chakstatas ()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var token = await prefs.get('token');
    var role= await prefs.get('role');
    if(token != null){
      goToDashbord(role);
    }
  }
  Future <void> loging()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var url = Uri.parse('http://68.178.163.174:5501/user/login');
    Map body = {
      'email': email.text,
      'password': password.text,
    };
    http.Response res = await http.post(url, body:body);

    var jsondata = jsonDecode(res.body);
    print (res.body);
    print(res.statusCode);


    if(res.statusCode==201) {
      await prefs.setString('token', jsondata['token']);
      await prefs.setString('user_id', jsondata['user_id'].toString());
      await prefs.setString('role', jsondata['role']);

      goToDashbord(jsondata['role']);
    }
    else if (res.statusCode == 404){
      Fluttertoast.showToast(
          msg: "Email Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else if (res.statusCode == 403){
      Fluttertoast.showToast(
          msg: "Password error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else  {
      Fluttertoast.showToast(
          msg: "Please Chak Your NET",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }
  void PhoneNumberChak(){
    auth.verifyPhoneNumber(
      phoneNumber:'+88'+ number.text,
        verificationCompleted:(PhoneAuthCredential credential)async{
        await auth.signInWithCredential(credential).then(
            (value) => print(' Login in successfully')
        );
        } ,
        verificationFailed:(err){
          Fluttertoast.showToast(
              msg: ' ${err.message}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          print(err);
        },
        codeSent: (verificationID,redendToken){
        setState(() {
          riceveid = verificationID;
          otpsend = true;
        });
        },
        codeAutoRetrievalTimeout:(verificationID){
        print('TimeOut');
        }
    );
  }
  void OTPChak ()async{
PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: riceveid, smsCode: otp.text);
await auth.signInWithCredential(credential).then((value) {
  Fluttertoast.showToast(
      msg: "Loggin Succssesful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Chakstatas();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body:

        Container(
          height: double.infinity,
          decoration:BoxDecoration(image: DecorationImage(image: AssetImage('Assets/Background.png'),fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: TextField(controller: email,
                decoration: InputDecoration(hintText: 'Email/Number',
                    labelText:'Enter Your Email',
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(2)) ),),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                child: TextField(controller: password,decoration: InputDecoration(hintText: 'Password',
                  labelText: 'Enter Your Password',
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(2))
                ),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                child: TextField(controller: number,decoration: InputDecoration(hintText: 'Number',
                    labelText: 'Enter Your Number',
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(2))
                ),),
              ),
              otpsend == true ? Container(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                child: TextField(controller: otp,decoration: InputDecoration(hintText: 'OTP',
                    labelText: 'OTP',
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(2))
                ),),
              ):
                  Text(' '),
              ElevatedButton(onPressed: (){
                loging();
                // if (otpsend == true){
                //   OTPChak();
                // }
                // else {
                //   PhoneNumberChak();
                // }
              // loging ();
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
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: Text('Register...?',style: TextStyle(color: Colors.green),),
                  )
                ],
              )
            ],
          ),
        ),
    );
  }
}
