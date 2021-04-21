import 'package:mediadrip/domain/drip/download_instructions.dart';
import 'package:mediadrip/domain/drip/drip.dart';
import 'package:mediadrip/domain/source/source.dart';

abstract class DownloadSource extends Source {
  DownloadInstructions configureDownload(Drip drip);
}