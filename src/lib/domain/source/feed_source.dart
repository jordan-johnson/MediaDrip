import 'package:mediadrip/domain/drip/drip.dart';
import 'package:mediadrip/domain/source/source.dart';

abstract class FeedSource extends Source {
  /// Label for views to use.
  String get display;

  /// Interprets an address and returns the correct address.
  /// 
  /// For example, a user may add a subreddit like https://reddit.com/r/news to 
  /// their feed. This will be interpreted and rerouted to 
  /// https://reddit.com/r/news/.json for future feed parsing.
  Future<String> interpret(String address);

  /// The methodology for reading a body of content.
  /// 
  /// For reddit, the content is the http response body which will be json.
  /// RedditSource decodes the json, and forms a RedditJsonModel from it.
  /// DripModels are then created and returned.
  /// 
  /// For youtube, [content] is xml and is parsed with an xml library.
  Future<List<Drip>> parse(String content);
}