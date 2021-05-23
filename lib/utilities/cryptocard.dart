import 'package:flutter/material.dart';
import 'constants.dart';

class CryptoCard extends StatefulWidget {
  final String _price;
  final String _cryptoticker;
  final String _cryptoname;
  final IconData _icon;
  @override
  CryptoCard(this._price,this._cryptoticker,this._cryptoname,this._icon);
  _CryptoCardState createState() => _CryptoCardState();
}

class _CryptoCardState extends State<CryptoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0XBA253743),
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Container(
              child: Icon(widget._icon,
                color: Colors.amber,),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black45
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],),
              width: 40,
              height: 40,),
            title: Text(widget._cryptoticker,
                style: kcoinTextStyle),
            trailing: Text('${widget._price.toString()}\$',
                style: knameTextStyle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            subtitle: Text(widget._cryptoname,
              style: knameTextStyle,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text('SEE MORE',style: TextStyle(
                    color: Color(0xffD5603A)
                ),),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  /* ... */
                },
                child: Icon(Icons.arrow_drop_down,size: 40,color: Color(0XFA33E1BA),),
              )
            ],
          ) */
        ],
      ),
    );
  }
}