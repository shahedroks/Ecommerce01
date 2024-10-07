import 'package:flutter/material.dart';

class Search extends StatelessWidget {
   Search({super.key});
  TextEditingController searsh = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 50,
        child: Card(
          child: Column(
            children: [
              GestureDetector(
                child:Icon(Icons.arrow_downward) ,
              ),
              TextField(
                controller: searsh,
              ),
              GestureDetector(child: Icon(Icons.search),)
            ],
          ),
        ),
      );
  }
}
