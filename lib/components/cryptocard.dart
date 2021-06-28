import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:crypto_ticker/screens/viewdetails.dart';

class CryptoCard extends StatelessWidget {
  final String _price;
  final String _cryptoticker;
  final String _cryptoname;
  final IconData _icon;
  final int index;
  final BuildContext _context;
  @override
  CryptoCard(this._price,this._cryptoticker,this._cryptoname,this._icon,this.index,this._context);
  Widget build(BuildContext context) {
    return Card(
      color: Color(0XBA253743),
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Container(
              child: Icon(_icon,
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
            title: Text(_cryptoticker,
                style: kcoinTextStyle),
            trailing: Text('${_price.toString()}\$',
                style: knameTextStyle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            subtitle: Text(_cryptoname,
              style: knameTextStyle,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text('DETAILS',style: TextStyle(
                    color: Color(0xffD5603A)
                ),),
                onPressed: () {
                  Navigator.push(_context, MaterialPageRoute(builder: (context)=>ViewDetails(_cryptoname, index)));
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}