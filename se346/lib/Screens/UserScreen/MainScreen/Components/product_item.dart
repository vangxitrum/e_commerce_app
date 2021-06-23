import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/Screens/UserScreen/ProductInfo/product_info.dart';
import 'package:se346/components/rounded_containter.dart';

class ProductItem extends StatelessWidget {
  final DocumentSnapshot product;
  final void Function() onChanged;
  const ProductItem({
    Key? key,
    required this.product,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return ProductInfo(product: product,);
                }
            )
        );
      },
      child: RoundedContainer(
          height: size.height * 0.25,
          width: size.width * 0.44,
          color: Colors.white,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product['imgSrc'],
                  height: size.height * 0.18,
                  width: size.width * 0.2,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(product['price'].toString(),),
                        //Text(product["amount"].toString())
                      ],
                    ),
                  ),
                  IconButton(onPressed: onChanged, icon: Icon(Icons.add)),
                ],
              )
            ],
          ),
          radius: 30),
    );
  }
}

