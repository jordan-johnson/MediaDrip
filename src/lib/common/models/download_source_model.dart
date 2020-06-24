import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/common/models/source_model.dart';

abstract class DownloadSourceModel extends SourceModel {
  Future<void> download(DripModel drip);
}