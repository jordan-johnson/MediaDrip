import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:mediadrip/common/models/index.dart';

abstract class BaseSource implements FeedSourceModel, DownloadSourceModel {
  @protected
  SettingsService settingsService = locator<SettingsService>();

  @protected
  String lookupInAddresses(String address) {
    for(var lookup in lookupAddresses) {
      if(address.contains(lookup)) {
        return lookup;
      }
    }

    return null;
  }
}