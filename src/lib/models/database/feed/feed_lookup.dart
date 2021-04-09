class FeedLookup {
  final int id;
  final String label;
  final String address;
  final int parentId;

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
}