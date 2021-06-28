import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto_ticker/utilities/constants.dart';
import 'package:crypto_ticker/services/chatservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_ticker/components/chatcard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'dashboard.dart';
import 'tweets.dart';
import 'package:crypto_ticker/components/sidedrawer.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _message;
  String _strmessage;
  FirebaseFirestore _chatobject;
  ChatService _chatService;
  SnackBar notifyUser;
  var messageController=TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ChatCard> _messagelist=[];
  BorderRadius kleftborder=BorderRadius.only(topRight: Radius.circular(8.0),bottomLeft: Radius.circular(8.0),bottomRight: Radius.circular(8.0));
  BorderRadius krightborder=BorderRadius.only(topLeft: Radius.circular(8.0),bottomLeft: Radius.circular(8.0),bottomRight: Radius.circular(8.0));
  @override
  void initState() {
    super.initState();
    this._chatobject=FirebaseFirestore.instance;
    _chatService=ChatService();
    notifyUser= SnackBar(content: Text('Not able to send message',style: kSnackTextStyle,));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                GestureDetector(child: Icon(CryptoFontIcons.BTC,size: 40,color:  Color(0xffD5603A),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                },),
                Icon(Icons.message,size: 40,color:  Color(0xffD5603A),),
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
        body:
        Builder(
           builder: (context)=>
        Container(
          decoration: BoxDecoration(gradient: kgradient),
          child: Column(
            children: [
              Expanded(flex: 11,
              child: StreamBuilder<QuerySnapshot>(
                stream: _chatobject.collection('chatstore').orderBy('creation_date').snapshots(),
                builder: (context,snapshot){
                  if(!snapshot.hasData)
                    {
                      return Center(
                        child: CircularProgressIndicator(
                        ),
                      );
                    }
                 final _messages=snapshot.data.docs.reversed;
                  _messagelist=[];
                  for (var msg in _messages)
                    {
                      final textmessage=msg.data()['message'];
                      final sender=msg.data()['sender'];
                      _strmessage=FirebaseAuth.instance.currentUser.email.toString();
                      if(sender==_strmessage.split('@')[0])
                      _messagelist.add(ChatCard(textmessage,sender,krightborder,kSendColor,CrossAxisAlignment.end,Color(0XFFA6B0B5)));
                      else
                        _messagelist.add(ChatCard(textmessage,sender,kleftborder,kRecieveColor,CrossAxisAlignment.start,Colors.white));
                    }
                  return ListView(reverse: true,children: _messagelist);
                },
              )),
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0XBA253743),
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        width: 20,
                        child: TextField(
                          controller: messageController,
                          style: kSnackTextStyle,
                          onChanged: (value) {
                            _message = value;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(onTap: (){
                      try {
                        _strmessage=FirebaseAuth.instance.currentUser.email.toString();
                        if(_message!='')
                     _chatService.sendMessage(_message, _strmessage.split('@')[0]);
                     setState(() {
                       _message='';
                     });
                      }
                      catch(e){
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(notifyUser);
                      }
                      messageController.clear();
                    }, child: Icon(
                      Icons.send_rounded,
                      size: 50,
                      color: Color(0xffD5603A),
                    )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),),
    );
  }
}
