import 'package:crypto_ticker/utilities/config.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String message;
  final String user;
  final BorderRadius kborderRadius;
  final Color kcolor;
  final CrossAxisAlignment kcross;
  final Color ktextColor;
  ChatCard(this.message,this.user,this.kborderRadius,this.kcolor,this.kcross,this.ktextColor);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: kcross,
        children: [
          Material(
            elevation: 8,
            borderRadius:kborderRadius,
            color: kcolor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: Text(this.message,style: TextStyle(
                fontSize: 25,
                color: ktextColor
              ),),
            ),
          ),
          Text(this.user,
          style: TextStyle(
            fontSize: 10,
            color: Color(0XFFA6B0B5)
          ),)
        ],
      ),
    );
  }
}
