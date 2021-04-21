class InstagramPostItem {
  final String id;
  final String fullSizeImage;
  final bool isVideo;

  InstagramPostItem.fromJson(Map<String, dynamic> json)
    : id = json['shortcode'],
      fullSizeImage = json['display_url'],
      isVideo = json['is_video'];
}

class InstagramPost implements InstagramPostItem {
  final String id;
  final String fullSizeImage;
  final bool isVideo;
  final int timestamp;
  final String thumbnail;
  final String videoUrl;
  final String description;
  final List<InstagramPostItem> children;

  String get postAddress => 'https://instagram.com/p/$id';

  InstagramPost.fromJson(Map<String, dynamic> json)
    : id = json['shortcode'],
      isVideo = json['is_video'],
      timestamp = json['taken_at_timestamp'],
      thumbnail = json['thumbnail_src'],
      fullSizeImage = json['display_url'],
      videoUrl = json['video_url'] ?? '',
      description = json['edge_media_to_caption']['edges'][0]['node']['text'] ?? '',
      children = (json['edge_sidecar_to_children'] != null) ? InstagramPost._parseChildren(json['edge_sidecar_to_children']) : <InstagramPostItem>[];
  
  static List<InstagramPostItem> _parseChildren(Map<String, dynamic> json) {
    List<InstagramPostItem> items = <InstagramPostItem>[];

    for(var child in json['edges']) {
      var item = InstagramPostItem.fromJson(child['node']);

      items.add(item);
    }

    return items;
  }
}

class InstagramJson {
  String username = '';
  List<InstagramPost> posts = <InstagramPost>[];

  InstagramJson.fromJson(Map<String, dynamic> json) {
    var userNode = json['entry_data']['ProfilePage'][0]['graphql']['user'];
    
    this.username = userNode['full_name'];
    var entries = userNode['edge_owner_to_timeline_media']['edges'];

    for(var entry in entries) {
      var model = InstagramPost.fromJson(entry['node']);

      posts.add(model);
    }
  }
}