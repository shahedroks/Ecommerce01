import 'package:ecommars/Function/Provider.dart';
import 'package:ecommars/Pages/AdminPage.dart';
import 'package:ecommars/Pages/CardView.dart';
import 'package:ecommars/Pages/Firebase%20Connecting.dart';
import 'package:ecommars/Pages/Loging%20Pages.dart';
import 'package:ecommars/Pages/Add_Product.dart';
import 'package:ecommars/Pages/Product.dart';
import 'package:ecommars/Pages/Profile.dart';
import 'package:ecommars/Pages/Register.dart';
import 'package:ecommars/Pages/User_id.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
options: FirebaseOptions(
    apiKey: "AIzaSyCQg0bRd12zReJtUkkeOhEn3p7-Sg2kik0",
    appId: "1:681987341104:android:91b989a4873e74bbce26f5",
    messagingSenderId:"681987341104",
    projectId: "ecomers-a59f3")
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) =>GetDataProvider())
  ],
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Logingpage(),
        '/userpage': (context) => UserPage(),
        '/adminpage' : (context) => AdminPage(),
        '/addproduct': (context) => DataAdd(),
        '/productdescription': (context)=> ProductDescription(),
        '/register': (context) => Register(),
        '/cardview':(context)=>Cardview(),
        '/profile':(context)=>Profile()    },
      debugShowCheckedModeBanner: false,
    ),
  ));
}