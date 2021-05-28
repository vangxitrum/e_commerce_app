import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Function press;
  const ItemCard({
    Key key,
    this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(40),
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 / 4),
            child: Text(
              // products is out demo list
              "Hi",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}