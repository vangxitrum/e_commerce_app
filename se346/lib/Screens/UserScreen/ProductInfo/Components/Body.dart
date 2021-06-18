import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se346/components/image_button.dart';
import 'package:se346/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Total: 200\$",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(width: size.width  * 0.1,),
          FlatButton(
              onPressed: (){
                setState(() {
                  productCount++;
                });
              },
              minWidth: size.width * 0.5,
              height: size.height * 0.1,
              color: Colors.lightBlueAccent,
              child: Text("Add to cart",style: TextStyle(fontSize: 18,color: Colors.white),),
            ),
        ],
      ),
      body: Container(
        height: size.height,
        width:  size.width,
        child: SingleChildScrollView(
          child:Column(
            children: [
              Row(
                children: [
                  ImageButton(
                      icnSrc: "assets/icons/back.svg",
                      press: (){
                        Navigator.pop(context);}),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/lol.png",
                        height: size.height * 0.4,
                        width: size.width * 0.4,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.1,),
                        Text("League of Legend",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        Text("Rito",style: TextStyle(color: Colors.black45,fontSize: 17),),
                        SizedBox(height: size.height * 0.05,),
                        Row(
                          children: [
                            ImageButton(icnSrc: 'assets/icons/remove.svg', press: (){}),
                            Text("1",style:TextStyle(fontSize: 30)),
                            ImageButton(icnSrc: 'assets/icons/add.svg', press: (){}),
                          ],
                        )
                      ],
                    )

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Divider(color: Colors.black54,thickness: 2,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Text("Describe",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Text(
                      "Liên Minh Huyền Thoại là một trò chơi video đấu trường trận chiến trực tuyến nhiều người chơi được Riot Games phát triển và phát hành trên nền tảng Windows và MacOS, lấy cảm hứng từ bản mod Defense of the Ancients ",
                      maxLines: 10,
                      style: TextStyle(fontSize: 14,letterSpacing: 1.5),
                    ),
                  )
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
