import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/download_source_model.dart';
import 'package:mediadrip/common/models/feed_source_model.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/settings_service.dart';

abstract class BaseSource implements FeedSourceModel, DownloadSourceModel {
  @protected
  SettingsService settingsService = locator<SettingsService>();
}