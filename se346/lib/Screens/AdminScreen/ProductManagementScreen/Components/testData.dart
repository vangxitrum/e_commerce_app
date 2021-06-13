

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/AdminScreen/ProductManagementScreen/Components/list_item.dart';

CollectionReference product = FirebaseFirestore.instance.collection('product');

class Product{
   DocumentSnapshot info;
  Product({
  required this.info
});
}

Future<void> addProduct(Product productInfo) async {
  String downloadURL = await FirebaseStorage.instance
      .ref('productInfo.productImgSrc')
      .getDownloadURL();
  // Call the user's CollectionReference to add a new user
  return product
      .add({
    'name': 'productInfo.productName', // John Doe
    'imgSrc': downloadURL, // Stokes and Sons
    'amount': 'productInfo.productAmount',
    'price' : 'productInfo.productPrice',
    'stop' : 'productInfo.setState',// 42
  })
      .then((value) => print("Product Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

class SearchService {
  searchByName(String value){
    return FirebaseFirestore.instance.collection('product')
        .where('searchKey', isEqualTo: value.substring(0, 1).toUpperCase());
  }
}

List<DocumentSnapshot> filteredList = [];
List<DocumentSnapshot> menuItem = [];
List<DocumentSnapshot> orderItemList = [];
List<DocumentSnapshot> orderList = [];


