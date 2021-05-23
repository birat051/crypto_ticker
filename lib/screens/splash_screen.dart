import 'package:crypto_ticker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
//import 'dashboard.dart';
import 'dart:io';
import 'package:crypto_ticker/services/crypto_service.dart';
import 'signin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CryptoService _callService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callService=CryptoService();
    checkConnection();
    getQuotes();
    // _setInstanceNumber();
    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => SignIn()));
    });

  }
  Future<void> getQuotes() async{
    await _callService.getCryptoQuotes();
  }
  void checkConnection() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      exit(0);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: kgradient
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/splash.gif'),
                  ),
                ),),
              //  SizedBox(height: 10,),
            ]),
      ),
    );
  }
}