import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommars/Custom%20Widget/CustomMap.dart';
import 'package:ecommars/Custom%20Widget/Navigation.dart';
import 'package:ecommars/Custom%20Widget/Product.dart';
import 'package:ecommars/Custom%20Widget/searchber.dart';
import 'package:ecommars/Function/Provider.dart';
import 'package:ecommars/Pages/Product.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';



class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List alldata = [];
  Map data ={};
  List image=[
  'Asstes/Offer.gif',
    'Asstes/Source.gif'
  ];
  var url=Uri.parse('sms:01717366199');
  // defind function
  void GetData () async {
    var url = Uri.parse('http://68.178.163.174:5501/product');
    Response res = await get(url);
    var decode = jsonDecode(res.body);
    setState(() {
      alldata=decode.map((el)=>Product.fromJson(el)).toList();
    });
  }
 void GetIDData()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
  String? id = pref.getString('user_id').toString();
  var url = Uri.parse('http://68.178.163.174:5501/user?id=${id}');
  Response res = await get(url);
  var decode = jsonDecode(res.body);
  setState(() {
    data = decode[0];
  });
 }
 void DeletID()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id').toString();
    var url = Uri.parse('http://68.178.163.174:5501/user/login?id=${user_id}');
    Response res = await delete(url);
    print(url);
    print(res.statusCode);
  }
  void LogOut()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.remove('user_id');
    prefs.remove('token');
    prefs.remove('role');
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
    GetIDData();
    DeletID();
  }
  @override
  Widget build(BuildContext context) {
    GetDataProvider provider = GetDataProvider.of(context);

    return
      Scaffold(
        drawer: Drawer(child:
        ListView(
          children: [
         SizedBox(
           height: 180,
           child: UserAccountsDrawerHeader(
             currentAccountPicture:data['profile_picture']!=null? ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(child: Image.network('${data['profile_picture']}'),),):ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.asset("Assets/Empty.jpg",fit: BoxFit.cover,),),
               accountName:data.isEmpty != true? Text('${data['name']}',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),):Text('shahed'),
               accountEmail:data.isEmpty != true ? Text('${data['email']}',style: TextStyle(color: Colors.black),):Text('shahed'),
               decoration: BoxDecoration(color: Color(0xffFDE992))),
         ),
            ListTile(
              onTap: (){
                Navigator.pushNamed(context, '/profile');
              },
              leading: Icon(Icons.person),
              title: Text('profile'),
            ),
            ListTile(
              onTap: (){
                launchUrl(Uri.parse('sms:01717366199'));
              },
              leading: Icon(Icons.contacts),
              title: Text('Contact'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.policy),
              title: Text('Policy'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('profile'),
            ),
            ListTile(
              leading: Icon(Icons.details),
              title: Text('Detalils'),
            ),
            ListTile(
              onTap: (){
                showDialog(context: context, builder: (BuildContext bc){
                  return AlertDialog(
                    title:Text('You Want To Logout') ,
                    actions: [
                      TextButton(onPressed: (){}, child: Text('No')),
                      TextButton(onPressed: (){
                        LogOut();

                      }, child: Text('Yos'))
                    ],
                  );
                });
              },
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
            ListTile(
              onTap: (){
              showDialog(context: context, builder:(BuildContext bc){
                return AlertDialog(
                  title: Text('You Want To Delete'),
                  actions: [
                    Row(
                      children: [
                        TextButton(onPressed: (){

                        }, child: Text('No')),
                        TextButton(onPressed: (){
                          DeletID();
                        }, child: Text('yes')),
                      ],
                    )
                  ],
                );
              });

              },
              leading: Icon(Icons.delete),
              title: Text('Delete Accaunt'),
            )
          ],
        )),
        appBar: AppBar(
            flexibleSpace: Image.asset('Assets/Buy.gif', fit: BoxFit.cover,),
            title: Text('Buy And Sell',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
            centerTitle: true,
            actions: [
              Stack(
                  children: [
                    GestureDetector(
                        onTap:(){
                          Navigator.pushNamed(context, '/cardview');
                        } ,
                        child: Container(
                          padding: EdgeInsets.only(right: 10,),
                            decoration: BoxDecoration(border:Border.all(color: Colors.black,)),
                            child: Icon(Ionicons.cart,size: 40,))),
                    Positioned(
                      top: 0,
                      right: 10,

                      child: Container(
                        width: 15,
                          height: 15,
                        decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(50)),

                        child: Text('${provider.cardQuantity}',style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.bold),),

                      ),
                    )
                  ],
              )
            ],
            backgroundColor: Colors.red[300]
        ),
        body:
        GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (1/1.6),
            crossAxisSpacing: 8,
            crossAxisCount: 2),
            children: alldata.map((i){
              return Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => ProductDescription(id: i.id ,)));
                    },
                      child: Custommap(image_url: i.image_url,name: i.name,price: i.price,rating: i.rating,description: i.description,)),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: GestureDetector(
                          onTap: (){
                            provider.AddToCard(i);
                          },
                          child: Icon(MaterialCommunityIcons.cart),),
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Text('Buy Naw',style: TextStyle(color: Colors.white),),
                        ),
                      )
                    ],
                  )

                ],
              );
            }).toList()
        ),
      );
  }
}
