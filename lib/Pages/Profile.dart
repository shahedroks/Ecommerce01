import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children:[
            Container(
            height: 200,
            width: double.infinity,
            child: Image.asset('Assets/Offer.gif',fit: BoxFit.cover,),),
            Positioned(
              top: 130,
              child: Container(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(50),
                  child: Image.asset('Assets/Empty.jpg',fit: BoxFit.cover,),
                ),
              ),
            ),

          ]
        ),
      ),
    );
  }
}
