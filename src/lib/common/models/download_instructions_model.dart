import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/drip_model.dart';

class DownloadInstructionsModel {
  String info;
  DripType type;
  String address;

  DownloadInstructionsModel({
    @required this.info,
    @required this.type,
    @required this.address
  });
}