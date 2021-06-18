import 'package:flutter/material.dart';
import 'package:se346/components/rounded_containter.dart';

class UserBuyProduct extends StatefulWidget {
  int amount;
  late int sum; // = amount * product price // :V them cai product nha
  UserBuyProduct({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  _UserBuyProductState createState() => _UserBuyProductState();
}

class _UserBuyProductState extends State<UserBuyProduct> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.01,),
        RoundedContainer(
            height: size.height * 0.18,
            width: size.width * 0.9,
            color: Colors.white,
            radius: 20,
            child: Column(
                children: [
                  SizedBox(height: size.height * 0.02,),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/images/lol.png',height: size.width * 0.17,width: size.width * 0.17,),
                        ),
                      ),
                      SizedBox(width: size.height * 0.01,),
                      Container(
                          width: size.width * 0.6,
                          height: size.height * 0.15,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("LOL",style:TextStyle(fontSize: 27)),
                              SizedBox(width: size.height * 0.03,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("100\$"),
                                  Text("x" + widget.amount.toString())
                                ],
                              ),
                              Divider(color: Colors.black54,thickness: 2,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("subtotal"),
                                  Text("200\$"  ) // cho nay dung sum.tostring nay :v dung cai sum de tong don hang cho de
                                ],
                              ),
                            ],
                          )
                      )
                    ],
                  )
                ]
            )
        )
      ],
    );;
  }
}
