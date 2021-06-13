

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/list_item.dart';

CollectionReference product = FirebaseFirestore.instance.collection('product');

class Product{
   String name;
   String imgSrc;
   int amount;
   int price;
   bool stop;
   String id = " ";
  Product({
    required this.name,
    required this.imgSrc,
    required this.amount,
    required this.price,
    required this.stop,
});

  set setState(bool stop){
     this.stop = stop;
  }

  set setId(String id){
    this.id = id;
  }

  bool get setState{
    return this.stop;
  }

  set productName(String name){
    this.name = name;
  }

  String get productName{
    return this.name;
  }

   set productImgSrc(String imgSrc){
     this.imgSrc = imgSrc;
   }

   String get productImgSrc{
     return this.imgSrc;
   }

   set productAmount(int amount){
     this.amount = amount;
   }

   int get productAmount{
     return this.amount;
   }

   set productPrice(int price){
     this.price = price;
   }

   int get productPrice{
     return this.price;
   }

}
Future<void> addProduct(Product productInfo) async {
  String downloadURL = await FirebaseStorage.instance
      .ref(productInfo.productImgSrc)
      .getDownloadURL();
  // Call the user's CollectionReference to add a new user
  return product
      .add({
    'name': productInfo.productName, // John Doe
    'imgSrc': downloadURL, // Stokes and Sons
    'amount': productInfo.productAmount,
    'price' : productInfo.productPrice,
    'stop' : productInfo.setState,// 42
  })
      .then((value) => print("Product Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
List<Product> menuItem = [
  Product(name: "xxx",imgSrc: "/lol.png",amount: 20,price: 50,stop: true),
  Product(name: "Dota",imgSrc: "/game_example.png",amount: 20,price: 50,stop: false),
  Product(name: "Overwatch",imgSrc: "/game_example.png",amount: 20,price: 53,stop: true),
  Product(name: "Valorant",imgSrc: "/game_example.png",amount: 20,price: 50,stop: false),
  Product(name: "Subnautica",imgSrc: "/game_example.png",amount: 20,price: 50,stop: true),
  Product(name: "Rust",imgSrc: "/game_example.png",amount: 20,price: 50,stop: true),
  Product(name: "Oxygen not included",imgSrc: "/game_example.png",amount: 20,price: 50,stop: false),
  Product(name: "The witch",imgSrc: "/game_example.png",amount: 20,price: 50,stop: true),
  Product(name: "Among us",imgSrc: "/game_example.png",amount: 20,price: 50,stop: false),
  Product(name: "LoL2",imgSrc: "/game_example.png",amount: 20,price: 50,stop: true)
];
List<Product> filteredList = [];


