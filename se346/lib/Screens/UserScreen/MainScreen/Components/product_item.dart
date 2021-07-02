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
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  height: size.height * 0.15,
                  width: size.height * 0.15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product['imgSrc'],
                      fit: BoxFit.cover ,),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child:Container(
                        width: size.width * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product['name'],style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                            product['sale'] == 0 ?
                            Text('\$' + product['price'].toString(),)
                                : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:
                                [
                                  Text('\$' + (product['price'] * (100 - product['sale'])/100).toString(),),
                                  Text(product['sale'].toString() + '\%',style: TextStyle(color:Colors.red),),
                                ]),
                          ],
                        ),
                      ),
                    ),
                    IconButton(onPressed: onChanged, icon: Icon(Icons.add)),
                  ],
                )
              ],
            ),
          ),
          radius: 30),
    );
  }
}

