import 'package:flutter/material.dart';
import 'package:mediadrip/domain/source/download_source.dart';
import 'package:mediadrip/domain/source/feed_source.dart';

abstract class BaseSource implements FeedSource, DownloadSource {
  @protected
  String validateAddress(String address) {
    // prepend https:// if not found
    if(!address.contains('https://')) {
      address = 'https://$address';
    }

    return address;
  }

  @override
  bool doesAddressExistInLookup(String address) {
    for(var lookup in lookupAddresses) {
      if(address.contains(lookup)) {
        return true;
      }
    }

    return false;
  }
}