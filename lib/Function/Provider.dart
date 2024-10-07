import 'dart:convert';

import 'package:ecommars/Custom%20Widget/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class GetDataProvider extends ChangeNotifier{
  List card =[];
 var cardQuantity =0;
 num totalPrice =0;
 void AddToCard(Product){
   if (card.contains(Product)){
     Product.quantity++;
     cardQuantity++;
     totalPrice += Product.price;
   }
   else{
     cardQuantity++;
     Product.quantity++;
     card.add(Product);
     totalPrice+=Product.price;
   }
   notifyListeners();
 }
 void RemoveFromCard (Product){
   if (Product.quantity>0) {
     Product.quantity --;
     cardQuantity--;
     totalPrice -= Product.price;
   }
   notifyListeners();
 }

  static GetDataProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<GetDataProvider>(
        context,
        listen: listen
    );
  }

}