import 'package:mediadrip/models/source/source.dart';
import 'package:mediadrip/models/file/download_instructions.dart';
import 'package:mediadrip/models/file/drip.dart';

abstract class DownloadSource extends Source {
  DownloadInstructions configureDownload(Drip drip);
}