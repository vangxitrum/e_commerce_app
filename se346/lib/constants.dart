
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kMenuBGColor = Colors.white;
const kMenuTextColor = Colors.black54;
const double kMenuTextFont = 18;

int productCount = 0;

//late List<DocumentSnapshot> listOrderInfo = [];

const Waiting = "Waiting";
const Cancel = "Cancel";
const Success = "Success";
const Unconfirmed = "Unconfirmed";

late int count = -1;
late int addCount = 0;
late int AddProductCount = -1;
