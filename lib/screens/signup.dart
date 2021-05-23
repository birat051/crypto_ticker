import 'package:flutter/material.dart';
import 'package:crypto_ticker/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_ticker/utilities/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email;
  String password;
  bool _saving=false;
  IconData _visibleicon =Icons.visibility;
  final _auth = FirebaseAuth.instance;
  bool passwordsecret = true;
  SnackBar notifyUser = SnackBar(
    content: Text(
      'Invalid format for email or Password',
      style: kSnackTextStyle,
    ),
    backgroundColor: Color(0xffD5603A),
  );
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Builder(
        builder: (context) => LoadingOverlay(
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(gradient: kgradient),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold,
                        color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  style: kSnackTextStyle,
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    suffixIcon: Icon(Icons.email,color: Colors.white,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: passwordsecret,
                  style: kSnackTextStyle,
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            if(passwordsecret)
                              passwordsecret=false;
                            else
                              passwordsecret=true;
                            if(_visibleicon==Icons.visibility)
                              _visibleicon=Icons.visibility_off;
                            else
                              _visibleicon=Icons.visibility;

                          });
                          print(passwordsecret);
                        },
                        child: Icon(_visibleicon,color: Colors.white,)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: Text('Register'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffD5603A)),
                        ),
                        onPressed: () async {
                          print(email);
                          print(password);
                          setState(() {
                            _saving=true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            setState(() {
                              _saving=false;
                            });
                          } catch (e) {
                            print(e);
                            setState(() {
                              _saving=false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(notifyUser);

                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text.rich(
                    TextSpan(text: 'Already have an account?\t',style: TextStyle(
                      fontSize: 15,color: Colors.white
                    ), children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(color: Color(0xffD5603A),
                            fontSize: 20),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),isLoading: _saving
        ),
      ),
    );
  }
}
