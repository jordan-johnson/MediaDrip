import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/services/feed_service.dart';
import 'package:mediadrip/services/sources/instagram_source.dart';
import 'package:mediadrip/services/sources/reddit_source.dart';
import 'package:mediadrip/services/sources/youtube_source.dart';

/// Loads the sources for both [FeedService] and [DownloadService].
void loadSources() {
  var feedService = locator<FeedService>();
  var downloadService = locator<DownloadService>();
  
  var youtubeSource = YoutubeSource();
  var redditSource = RedditSource();
  var instagramSource = InstagramSource();

  feedService.addSource<YoutubeSource>(youtubeSource);
  feedService.addSource<RedditSource>(redditSource);
  feedService.addSource<InstagramSource>(instagramSource);
  
  downloadService.addSource<RedditSource>(redditSource);
  downloadService.addSource<YoutubeSource>(youtubeSource);
  // downloadService.addSource<InstagramSource>(instagramSource);
}