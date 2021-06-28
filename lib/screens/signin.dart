import 'package:crypto_ticker/utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:crypto_ticker/utilities/constants.dart';
import 'package:crypto_ticker/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dashboard.dart';
import 'package:provider/provider.dart';
import 'package:crypto_ticker/services/crypto_service.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email;
  String password;
  bool _saving=false;
  bool passwordsecret = true;
  IconData _visibleicon =Icons.visibility;
  final _auth=FirebaseAuth.instance;
  SnackBar notifyUser= SnackBar(content: Text('Invalid Username or Password',style: kSnackTextStyle,),
    backgroundColor: Color(0xffD5603A),);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => CryptoService(),
      child: WillPopScope(
        onWillPop: (){
          SystemNavigator.pop();
          return;
        },
        child: Scaffold(
            body: Builder(
              builder: (context)=> SafeArea(
                child: LoadingOverlay(
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                        gradient: kgradient
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Login',
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
                          style: kSnackTextStyle,
                          onChanged: (value) {
                            email = value;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
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
                          style: kSnackTextStyle,
                          onChanged: (value) {
                            password = value;
                          },
                          obscureText: passwordsecret,
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
                               //   print(passwordsecret);
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
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                      /*        Text(
                                'Forget password?',
                                style: TextStyle(fontSize: 15.0
                                ,color: Color(0XFFD5603A)),
                              ), */
                              ElevatedButton(
                                child: Text('Login'),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Color(0xffD5603A)),
                                ),
                                onPressed: () async{
                                  print(email);
                                  print(password);
                                  setState(() {
                                    _saving=true;
                                  });
                                  try{
                                    final newUser= await _auth.signInWithEmailAndPassword(email: email, password: password);
                                    if (newUser!=null) {
                                      kUser=email;
                                      print('New user: $newUser');
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => DashBoard()));
                                    }
                                    setState(() {
                                      _saving=false;
                                    });
                                  }
                                  catch(e){
                                    setState(() {
                                      _saving=false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(notifyUser);
                                    print(e);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                          },
                          child: Text.rich(
                            TextSpan(text: 'Don\'t have an account?\t',style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ), children: [
                              TextSpan(
                                text: 'Signup',
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
            )

          ),
      ),
    );
  }
}


