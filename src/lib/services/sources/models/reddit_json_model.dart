class RedditJsonDataModel {
  final String title;
  final String author;
  final String thumbnail;
  final String url;
  final double created;
  final String textContent;

  RedditJsonDataModel.fromJson(Map<String, dynamic> json)
    : title = json['data']['title'],
      author = json['data']['author'],
      created = json['data']['created'],
      thumbnail = json['data']['thumbnail'],
      url = json['data']['url'],
      textContent = json['data']['selftext'];
}

class RedditJsonModel {
  List<RedditJsonDataModel> data = List<RedditJsonDataModel>();

  RedditJsonModel.fromJson(Map<String, dynamic> json) {
    for(var entry in json['data']['children']) {
      var dataModel = RedditJsonDataModel.fromJson(entry);

      if(dataModel != null) {
        data.add(dataModel);
      }
    }
  }
}