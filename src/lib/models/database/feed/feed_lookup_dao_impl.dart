import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/database/feed/feed_lookup.dart';
import 'package:mediadrip/models/database/feed/feed_lookup_dao.dart';
import 'package:mediadrip/services/database/data_source.dart';
import 'package:mediadrip/services/database/sqlite_database.dart';
import 'package:sqlite3/sqlite3.dart';

class FeedLookupDaoImpl extends FeedLookupDao {
  final DataSource<Database> _dataSource = locator<SqliteDatabase>();
  final String _tableName = 'feed_lookup';

  List<FeedLookup> getAllFeeds() {
    var feeds = <FeedLookup>[];

    _dataSource.execute((source) {
      final results = source.select('SELECT * FROM feed_lookup');

      for(final row in results) {
        final feed = FeedLookup.fromMap(row);

        feeds.add(feed);
      }
    });

    return feeds;
  }

  FeedLookup getFeedLookupById(int id) {
    FeedLookup feed;

    _dataSource.retrieve<FeedLookup>((source) {
      final results = source.select('SELECT * FROM $_tableName WHERE id = $id LIMIT 1');

      return FeedLookup.fromMap(results?.first);
    }).then((value) => feed = value);

    return feed;
  }

  void insertFeedLookup(FeedLookup feed) {
    _dataSource.execute((source) {
      final statement = source.prepare('INSERT INTO $_tableName (label, address, parent_id) VALUES (?, ?, ?)');
      
      statement.execute([feed.label, feed.address, feed.parentId]);
      statement.dispose();
    });
  }

  void updateFeedLookup(FeedLookup feed) {
    _dataSource.execute((source) {
      final statement = source.prepare('UPDATE $_tableName SET label = ?, address = ?, parent_id = ? WHERE id = ${feed.id}');

      statement.execute([feed.label, feed.address, feed.parentId]);
      statement.dispose();
    });
  }

  void deleteFeedLookup(FeedLookup feed) {
    _dataSource.execute((source) =>
      source.execute('DELETE FROM $_tableName WHERE id = ${feed.id}'));
  }

  void deleteFeedLookupById(int id) {
    final feed = getFeedLookupById(id);

    deleteFeedLookup(feed);
  }
}