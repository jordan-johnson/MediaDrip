import 'package:flutter/material.dart';
import 'package:mediadrip/models/file/drip.dart';

class DownloadInstructions {
  final String fileName;
  final DripType type;
  final String address;

  DownloadInstructions({
    @required this.fileName,
    @required this.type,
    @required this.address
  });
}