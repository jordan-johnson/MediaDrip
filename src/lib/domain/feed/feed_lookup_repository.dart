import 'package:mediadrip/domain/feed/feed_lookup.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/database/sqlite_database.dart';

class FeedLookupRepository {
  final SqliteDatabase _dataSource = locator<SqliteDatabase>();

  Future<List<FeedLookup>> getAllFeeds() async {
    return await _dataSource.retrieve<List<FeedLookup>>((source) {
      final results = source.select('SELECT * FROM ${FeedLookup.tableName}');

      List<FeedLookup> feeds = <FeedLookup>[];

      for(final row in results) {
        final feed = FeedLookup.fromMap(row);

        feeds.add(feed);
      }

      return feeds;
    });
  }

  Future<void> saveFeed(FeedLookup feed) async {
    return await _dataSource.execute((source) {
      final statement = source.prepare(FeedLookup.insertStatement);

      statement.execute(feed.insertParameters());
      statement.dispose();
    });
  }

  Future<void> deleteFeed(FeedLookup feed) async {
    return await _dataSource.execute((source) {
      source.execute('DELETE FROM ${FeedLookup.tableName} WHERE id = ${feed.id}');
    });
  }
}