import 'package:mediadrip/common/models/source_model.dart';

abstract class DownloadSourceModel extends SourceModel {
  Future<void> download(String address);
}