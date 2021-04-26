class FeedLookup {
  static final tableName = 'feed_lookup';

  final int id;
  final String label;
  final String address;
  final int parentId;

  static String insertStatement = 'INSERT INTO $tableName (label, address, parent_id) VALUES (?, ?, ?)';

  FeedLookup(
    this.id,
    this.label,
    this.address,
    this.parentId
  );

  FeedLookup.fromMap(Map<String, dynamic> map) :
    this.id = map['id'],
    this.label = map['label'],
    this.address = map['address'],
    this.parentId = map['parent_id'];

  List<String> insertParameters() {
    return [this.label, this.address, this.parentId.toString()];
  }
}