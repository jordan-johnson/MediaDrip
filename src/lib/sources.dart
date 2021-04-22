import 'package:mediadrip/domain/source/source_repository.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/sources/instagram_source.dart';
import 'package:mediadrip/services/sources/reddit_source.dart';
import 'package:mediadrip/services/sources/youtube_source.dart';

void loadSources() {
  var sourceRepository = locator<SourceRepository>();
  var youtubeSource = YoutubeSource();
  var redditSource = RedditSource();
  var instagramSource = InstagramSource();

  sourceRepository.addSource(youtubeSource);
  sourceRepository.addSource(redditSource);
  sourceRepository.addFeedSource(instagramSource);
}