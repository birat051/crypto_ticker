import 'package:flutter/material.dart';
import 'package:crypto_ticker/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_ticker/screens/signin.dart';
class SideNavigation extends StatelessWidget {
  final String user=FirebaseAuth.instance.currentUser.email.split('@')[0];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Container(
      width: width*0.5,
      child: Drawer(
        child: Container(
         // color: Color(0XBA253743),
          decoration: BoxDecoration(
           gradient: kgradient
          //  color: kSendColor
          ),
          //width: 40,
          padding: EdgeInsets.fromLTRB(10, 60, 10, 20),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.person,
                  size: 40,
                  color: kRecieveColor,),
              ),
              SizedBox(height: 10,),
              Text(
                user,
                style: kSnackTextStyle,
              ),
              SizedBox(height: 10,),
              GestureDetector(
                child: Text(
                  'Logout',
                  style: kSnackTextStyle,
                ),
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, new MaterialPageRoute(builder:  (BuildContext context) => SignIn()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
