
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

late String _image = "";
final picker = ImagePicker();
final String path = 'avatar/' + FirebaseAuth.instance.currentUser!.uid.toString() + '.png';
late String avatarURL = "";

Future getImageSource(ImageSource imageSource) async {
  final pickedFile = await picker.getImage(source: imageSource);
  if (pickedFile != null) {
    _image = pickedFile.path;
    await uploadAvatar(_image);
    await getAvatarURL();
    if(avatarURL != ""){
      FirebaseAuth.instance.currentUser!.updatePhotoURL(avatarURL);
      FirebaseAuth.instance.currentUser!.reload();
    }
  } else {
    _image = "";
    print('No image selected.');
  }
}

Future<void> uploadAvatar(String filePath) async {
  File file = File(filePath);
  try {
    await FirebaseStorage.instance
        .ref(path)
        .putFile(file);
  } on FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
  }
}

Future<void> getAvatarURL() async {
  String downloadURL = await FirebaseStorage.instance
      .ref(path)
      .getDownloadURL();
  print("downloadURL " + downloadURL);
  avatarURL = downloadURL;
  // Within your widgets:
  // Image.network(downloadURL);
}


void getImage(BuildContext context) {
  if(Platform.isAndroid){
    showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text("Camera"),
            onTap: (){
              Navigator.pop(context);
              getImageSource(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text("Gallery"),
            onTap: (){
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