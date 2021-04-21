import 'package:flutter/material.dart';
import 'package:mediadrip/domain/source/download_source.dart';
import 'package:mediadrip/domain/source/feed_source.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/settings_service.dart';

abstract class BaseSource implements FeedSource, DownloadSource {
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

  @protected
  String validateAddress(String address) {
    // prepend https:// if not found
    if(!address.contains('https://')) {
      address = 'https://$address';
    }

    return address;
  }
}