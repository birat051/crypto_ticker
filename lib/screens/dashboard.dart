import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto_ticker/utilities/constants.dart';
import 'package:crypto_ticker/components/cryptocard.dart';
import 'package:crypto_ticker/utilities/crypto_list.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'chatscreen.dart';
import 'tweets.dart';
import 'package:crypto_ticker/services/crypto_service.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:crypto_ticker/components/sidedrawer.dart';



class DashBoard extends StatefulWidget {

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isLoading=true;
  var _timer;
  Future<void> setPrice() async
  {
    await Provider.of<CryptoService>(context,listen: false).getCryptoQuotes();
    setState(() {
      isLoading=false;
    });
  }
  void initState() {
    super.initState();
    const oneSec = const Duration(seconds:2);
    _timer= Timer.periodic(oneSec, (Timer t) => setPrice());
  }
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        SystemNavigator.pop();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: kgradient
            ),
          ),
          title: Center(
           child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TwitterFeedView()));
                    },
                    child: Icon(FontAwesomeIcons.twitter,size: 40,color:  Color(0xffD5603A),)),
                Icon(CryptoFontIcons.BTC,size: 40,color:  Color(0xffD5603A),),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                    },
                    child: Icon(Icons.message,size: 40,color:  Color(0xffD5603A),)),
              ],
            ),
          ),
        //  backgroundColor: kSendColor,
          leading: IconButton(
            icon: Icon(Icons.menu, size: 40,color: kRecieveColor,), // change this size and style
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
        ),
          key: _scaffoldKey,
          drawer: SideNavigation(),
        body: Container(
          decoration: BoxDecoration(
              gradient: kgradient
          ),
          height: double.infinity,
          width: double.infinity,
          child: isLoading? Center(child: CircularProgressIndicator(color: kRecieveColor,)):Column(
              children:[ Expanded(
                  flex:11,
                  child:
                  ListView.builder(itemBuilder: (context,index){
                    if(index<kcrypto_ticker.length)
                        return CryptoCard(Provider.of<CryptoService>(context).price[index].replaceRange(9, Provider.of<CryptoService>(context).price[index].length, ''), kcrypto_ticker[index],kcrypto_name[index].toUpperCase(),cryptoicons[index],index,context);
                  }
                  )
              ),
              ]
          ),
        ),
      ),
    );
  }
}

