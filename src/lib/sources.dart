import 'package:mediadrip/locator.dart';
import 'package:mediadrip/common/models/feed_source_model.dart';
import 'package:mediadrip/services/feed_service.dart';
import 'package:mediadrip/services/sources/reddit_source.dart';
import 'package:mediadrip/services/sources/youtube_source.dart';

void loadSources() {
  var feedService = locator<FeedService>();
  
  var youtubeSource = YoutubeSource();
  var redditSource = RedditSource();

  feedService.addSource<YoutubeSource>(youtubeSource);
  feedService.addSource<RedditSource>(redditSource);
}