import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class ChatService{
  FirebaseFirestore _chatobject;
  String _message;
  String _sender;
  ChatService()
  {
    this._chatobject=FirebaseFirestore.instance;
  }
  void sendMessage(String message,String sender) async{
    this._message=message;
    this._sender=sender;
    final creation_date=FieldValue.serverTimestamp();
    try{
      print(creation_date);
    await _chatobject.collection('chatstore').add({'message':this._message,
    'sender':this._sender,'creation_date': FieldValue.serverTimestamp()
    });}
    catch(e){
      throw e;
    }
  }
}