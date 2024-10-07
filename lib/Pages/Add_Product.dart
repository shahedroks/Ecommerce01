import 'dart:convert';
import 'dart:io';

import 'package:ecommars/Function/GetData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
class DataAdd extends StatefulWidget {



  DataAdd({super.key});

  @override
  State<DataAdd> createState() => _DataAddState(); }


  class _DataAddState extends State<DataAdd> {

    // Text Controler
    TextEditingController id = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController rating = TextEditingController();
    TextEditingController description = TextEditingController();
    File? image;


    void adddata()async {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://68.178.163.174:5501/product/add'));
      request.files.add(await http.MultipartFile.fromPath('image', image!.path));
      request.fields['name'] = name.text;
      request.fields['price'] = price.text;
      request.fields['description'] = description.text;
      request.fields['rating'] = rating.text;
      http.StreamedResponse res = await request.send();

        GetData();
        Navigator.pushNamed(context, '/mainpage');

    }


    // funtion

    void soucegallary ()async{
      var imagepicker = ImagePicker();
      var file =await imagepicker.pickImage(source: ImageSource.gallery);
      if ( file != null) {
        setState((){
          image  =File(file.path);
        });
      }
    }
    void soucecamera ()async{
      var imagepicker = ImagePicker();
      var file = await imagepicker.pickImage(source: ImageSource.camera);
      if (file != null) {

        setState((){
          image = File(file.path);
        });
      }
    }
    List data = [];
    void GetData ()async{
      var url = Uri.parse('http://68.178.163.174:5501/product');
      http.Response res = await http.get(url);
      var jesondata = jsonDecode(res.body);

       data=jesondata;


    }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
  }
  @override
  Widget build(BuildContext context) {

  return Scaffold(
  body: SingleChildScrollView(
    child: Column(
    children: [
    SizedBox(height: 60,),
    GestureDetector(
      onTap: (){
        // add image


        showModalBottomSheet(context: context, builder: (BuildContext bc){
          return Container(
            width: double.infinity,
            height:250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){

                    soucegallary();
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt),
                        Text('Chucs Grom Gallary')
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    soucecamera();
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.browse_gallery),
                        Text('Chucs Grom Gallary')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
      // Text Controler

      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
          color: Color(0xffF5A8B8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add),
          Text('Add Image')
        ],
      ),),
    ),

    Container(
        margin: EdgeInsets.symmetric(horizontal: 10 ,vertical: 5),
        child: TextField(
          controller: name,
          decoration: InputDecoration(hintText:'name',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1)
              ),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2))
          ),
        )
    ),
    Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: TextField(
          controller: description,
          decoration: InputDecoration(hintText:'description',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1)
              ),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2))
          ),
        )
    ),
    Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: TextField(
        controller: price,
        decoration: InputDecoration(hintText:'price',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1)
            ),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2))
        ),
      ),
    ),Container(
    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: TextField(
        controller: rating,
        decoration: InputDecoration(hintText:'Rating',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1)
            ),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2))
        )
    ),),
    SizedBox(height: 10,),
    ElevatedButton(onPressed: (){
      adddata();

    },
    style: ElevatedButton.styleFrom(backgroundColor: Colors.green,shadowColor: Colors.yellow,elevation: 10,),
    child: Text('Submeat')),
      SizedBox(height: 90,),
      image != null ?  Container(
        width: 400,
        height: 400,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 20,
              child: Image(image: FileImage(image!),fit: BoxFit.fill, ))) : Text(''),


    ],
    ),
  ),
  );
  }
  }

