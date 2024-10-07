import 'package:ecommars/Function/Provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_rating/flutter_rating.dart';
class Cardview extends StatefulWidget {
  var id;
  Cardview({super.key,this.id});

  @override
  State<Cardview> createState() => _CardviewState();
}

class _CardviewState extends State<Cardview> {

  @override
  Widget build(BuildContext context) {
    GetDataProvider provider = GetDataProvider.of(context);
    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text('Card',style: TextStyle(fontWeight: FontWeight.bold),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children:provider.card.map((_element){
                return Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(color: Color(0xffFDE992),borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(


                        width: 150,
                        height: 100,
                        child:Image.network('${_element.image_url}',fit: BoxFit.cover,)),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          Text('${_element.name}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          Spacer(),
                          StarRating(
                            rating: _element.rating.toDouble(),color: Colors.red,
                          )
                        ],
                      )


                    ],
                  ),
                );
              }).toList(),

            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                      child: Text('TK \t ${provider.totalPrice}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 50,
                    child: Text('Buy',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    decoration: BoxDecoration(color: Colors.green),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
