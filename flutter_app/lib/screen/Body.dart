import 'package:flutter/material.dart';
import 'package:flutter_app/screen/DetailScreen.dart';

import 'Categories.dart';
import 'ItemCard.dart';

class Body extends StatelessWidget{
  @override
    Widget build(BuildContext context){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Categories(),
          Expanded(
            child: GridView.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                //crossAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => ItemCard(
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen()
                  )
                ),
              )
              ),
            ),
        ],
      );
  }
}

