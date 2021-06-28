import 'package:crypto_ticker/screens/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';
import '../services/twitter_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_ticker/utilities/constants.dart';
import 'dashboard.dart';
import 'package:crypto_ticker/components/sidedrawer.dart';


class TwitterFeedView extends StatefulWidget {
  const TwitterFeedView({Key key}) : super(key: key);


  @override
  _TwitterFeedViewState createState() => _TwitterFeedViewState();
}

class _TwitterFeedViewState extends State<TwitterFeedView> {
  List tweetsJson = [];
  String errorMessage = '';

  @override
  void initState() {
    getTweets();
    super.initState();
  }

  // Get tweets from Twitter Service
  Future getTweets() async {
    final twitterService = TwitterService('crypto');

    try {
      final List response = await twitterService.getTweetsQuery();

      setState(() {
        tweetsJson = response;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error retrieving tweets, please try again later.';
      });
    }
  }
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Icon(FontAwesomeIcons.twitter,size: 40,color:  Color(0xffD5603A),),
              GestureDetector(child: Icon(CryptoFontIcons.BTC,size: 40,color:  Color(0xffD5603A),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
              },),
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
        child: Column(
          children: [

            Expanded(
              flex:11,
              child: RefreshIndicator(
                onRefresh: () => getTweets(),
                child: tweetsJson.isEmpty
                    ? errorMessage.isEmpty
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Center(
                  child: Text(errorMessage),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  itemCount: tweetsJson.length,
                  itemBuilder: (context, index) {
                    return
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: EmbeddedTweetView.fromTweet(
                          Tweet.fromJson(tweetsJson[index]),
                          darkMode: true,
                          backgroundColor: Colors.transparent,
                          useVideoPlayer: false,
                        ),
                      );
                  },
                ),
              ),
            ),
        /*    Expanded(
              flex: 1,
                child: Container(
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
                        GestureDetector(onTap: (){

                        },
                            child: Icon(FontAwesomeIcons.twitter,size: 40,color:  Color(0xffD5603A),)),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                            },
                            child: Icon(CryptoFontIcons.BTC,size: 40,color:  Color(0xffD5603A),)),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                            },
                            child: Icon(Icons.message,size: 40,color:  Color(0xffD5603A),)),
                      ],
                    ),
                  ),
                )) */
          ],
        ),
      ),
    );
  }
}