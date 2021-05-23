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
    path="search/tweets.json";
  }
  Future<List> getTweetsQuery() async {
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
          "count": "10",
        },
      );

      final decodedResponse = json.decode(response.body);
      return decodedResponse['statuses'] as List;
    } catch (error) {
      rethrow;
    }
  }

}