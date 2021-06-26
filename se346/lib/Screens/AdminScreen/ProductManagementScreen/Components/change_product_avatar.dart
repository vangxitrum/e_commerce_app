
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();

class GetImageProduct {
  final DocumentSnapshot product;
  late String path = "product/" + product.id;
  late String imageURL = "";
  late String image = "";

  GetImageProduct(this.product);

  Future<void> getImage(BuildContext context) async {
    if(Platform.isAndroid){
      showModalBottomSheet(
          context: context,
          builder: (context) => Wrap(children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                getImageSource(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                getImageSource(ImageSource.gallery);
              },
            )
          ],
          )
      );
    }
    else{
      showCupertinoModalPopup(context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text("Camera"),
                onPressed: (){
                  Navigator.pop(context);
                  getImageSource(ImageSource.camera);
                },
              ),
              CupertinoActionSheetAction(
                child: Text("Gallery"),
                onPressed: (){
                  Navigator.pop(context);
                  getImageSource(ImageSource.gallery);
                },
              ),
            ],
          )
      );
    }
  }

  Future<String> getImageURL() async {
    String downloadURL = await FirebaseStorage.instance
        .ref().child(path)
        .getDownloadURL();
    imageURL = downloadURL;
    return downloadURL;
    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<void> uploadImage(String filePath) async {
    File file = File(filePath);
    try {
      await FirebaseStorage.instance
          .ref().child(path)
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> update(String pathURL){
    return product.reference.update({
      'imgSrc' : pathURL,
      'amount' : 1
    }).whenComplete(() {
      print("Update Complete");
      print(imageURL);
      print(product.id);
      print(product['imgSrc']);
    });
  }

  void getImageSource(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile != null) {
      image = pickedFile.path;
      print(image);
      await uploadImage(image).whenComplete(() async {
        print("UpLoad Complete");
        String pathURL = await getImageURL();
          if(pathURL != ""){
            update(pathURL);
            //print("befor reload: " + FirebaseAuth.instance.currentUser!.photoURL!);
            //print("after reload: " + FirebaseAuth.instance.currentUser!.photoURL!);
          }
      });
    } else {
      image = "";
      print('No image selected.');
    }
  }
}




