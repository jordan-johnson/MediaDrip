import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/common/models/source_model.dart';

abstract class FeedSourceModel extends SourceModel {
  Future<List<DripModel>> parse(String content);
}