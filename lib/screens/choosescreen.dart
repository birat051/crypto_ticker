import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signin.dart';
import 'dashboard.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ChooseScreen extends StatefulWidget {
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseAuth.instance.currentUser != null
          ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => DashBoard()))
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => SafeArea(
          child: LoadingOverlay(
            isLoading: true,
              child: Container()
          )
      ,),
    ));
  }
}
