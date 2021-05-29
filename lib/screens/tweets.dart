import 'package:crypto_ticker/screens/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';
import '../services/twitter_api.dart';
import 'dashboard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_ticker/utilities/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("CryptoTrendingTweets",
      ),
        ),),
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
                    : Expanded(
                  flex: 11,
                      child: ListView.builder(
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
            ),
            Expanded(
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                            },
                            child: Icon(CryptoFontIcons.BTC,size: 40,color:  Color(0xffD5603A),)),
                        GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                            },
                            child: Icon(Icons.message,size: 40,color:  Color(0xffD5603A),)),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}