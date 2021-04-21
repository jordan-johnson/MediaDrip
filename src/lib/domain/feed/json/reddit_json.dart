class RedditJsonThreadData {
  final String title;
  final String author;
  final String thumbnail;
  final String url;
  final double created;
  final String textContent;
  final bool isVideo;
  final bool isSelfText;

  RedditJsonThreadData.fromJson(Map<String, dynamic> json)
    : title = json['data']['title'],
      author = json['data']['author'],
      created = json['data']['created_utc'],
      thumbnail = json['data']['thumbnail'],
      url = json['data']['url'],
      textContent = json['data']['selftext'] ?? '',
      isVideo = json['data']['is_video'],
      isSelfText = json['data']['is_self'];
}

class RedditJson {
  List<RedditJsonThreadData> data = <RedditJsonThreadData>[];

  RedditJson.fromJson(Map<String, dynamic> json) {
    for(var entry in json['data']['children']) {
      var dataModel = RedditJsonThreadData.fromJson(entry);

      if(dataModel != null) {
        data.add(dataModel);
      }
    }
  }
}