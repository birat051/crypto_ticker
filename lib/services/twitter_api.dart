import 'package:twitter_api/twitter_api.dart';
import 'package:crypto_ticker/utilities/config.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TwitterService{
  String queryTag;
  twitterApi _twitterAPI;
  String path;
  TwitterService(this.queryTag)
  {
    _twitterAPI = twitterApi(
      consumerKey: kconsumerAPIkey,
      consumerSecret: kconsumerAPIsecret,
      token: kaccesstoken,
      tokenSecret: ksecretaccesstoken,
    );
    this.path="search/tweets.json";
  }
  Future<List> getTweetsQuery() async {
    print('Path is $path');
    print('QueryTag is $queryTag');
    try {
      // Make the request to twitter
      Response response = await _twitterAPI.getTwitterRequest(
        // Http Method
        "GET",
        // Endpoint you are trying to reach
        path,
        // The options for the request
        options: {
          "q": queryTag,
          "count": "50",
          "tweet_mode": "extended",
        },
      );
      final decodedResponse = json.decode(response.body);
      print('Response recieved from twitter API is ${decodedResponse['statuses']}');
       return decodedResponse['statuses'] as List;
    } catch (error) {
      rethrow;
    }
  }
}