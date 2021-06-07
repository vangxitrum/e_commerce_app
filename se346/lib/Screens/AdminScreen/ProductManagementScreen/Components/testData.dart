

import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/list_item.dart';

class Product{
   String name;
   String imgSrc;
   int amount;
   int price;
   bool stop;

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

List<Product> menuItem = [
  Product(name: "xxx",imgSrc: "assets/images/lol.png",amount: 20,price: 50,stop: true),
  Product(name: "Dota",imgSrc: "assets/images/game_example.png",amount: 20,price: 50,stop: false),
  Product(name: "Overwatch",imgSrc: "assets/images/game_example.png",amount: 20,price: 53,stop: true),
  Product(name: "Valorant",imgSrc: "assets/images/game_example.png",amount: 20,price: 50,stop: false),
  Product(name: "Subnautica",imgSrc: "assets/images/game_example.png",amount: 20,price: 50,stop: true),
  Product(name: "Rust",imgSrc: "assets/images/game_example.png",amount: 20,price: 50,stop: true),
  Product(name: "Oxygen not included",imgSrc: "assets/images/game_example.png",amount: 20,price: 50,stop: false),
  Product(name: "The witch",imgSrc: "assets/images/game_example.png",amount: 20,price: 50,stop: true),
  Product(name: "Among us",imgSrc: "assets/images/game_example.png",amount: 20,price: 50,stop: false),
  Product(name: "LoL2",imgSrc: "assets/images/game_example.png",amount: 20,price: 50,stop: true)

];


List<Product> filteredList = [];


