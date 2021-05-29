import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto_ticker/utilities/constants.dart';
import 'package:crypto_ticker/utilities/cryptocard.dart';
import 'package:crypto_ticker/utilities/crypto_list.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'chatscreen.dart';
import 'tweets.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {

 // List<String> _price;
 // String _get_price;
   // TwitterService tweets;
  List<CryptoCard> getCryptoList(){
    List<CryptoCard> cryptocardlist = [];
    for(int i=0;i<kcrypto_ticker.length;i++)
      {
        cryptocardlist.add(CryptoCard(price[i].replaceRange(9, price[i].length, ''),kcrypto_ticker[i],kcrypto_name[i].toUpperCase(),cryptoicons[i]));
      }
    return cryptocardlist;
  }
  @override
  void initState() {
   // tweets=TwitterService('crypto');
   // getTweets();
    super.initState();
  }
 /* void getTweets() async{
    try {
      await tweets.getTweetsQuery();
    }
    catch(e){
      print(e);
    }
  }  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: kgradient
        ),
        child: Column(
          children:[ Expanded(
            flex:11,
            child: ListView(
              shrinkWrap: true,
              children:
                getCryptoList(),
            ),

          ),
          Expanded(child: Container(
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color:Color(0XBA253743),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TwitterFeedView()));
            },
                      child: Icon(FontAwesomeIcons.twitter,size: 40,color:  Color(0xffD5603A),)),
                  Icon(CryptoFontIcons.BTC,size: 40,color:  Color(0xffD5603A),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                      },
                      child: Icon(Icons.message,size: 40,color:  Color(0xffD5603A),)),
                ],
              ),
            ),
          ))
          ]
        ),
      ),
    );
  }
}