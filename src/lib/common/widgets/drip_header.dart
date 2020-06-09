import 'package:flutter/material.dart';
import 'package:mediadrip/common/theme.dart';

class DripHeader extends StatelessWidget {
  final IconData icon;
  final String header;
  final String subHeader;

  const DripHeader({
    @required this.icon,
    @required this.header,
    this.subHeader
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Row(
              children: [
                SizedBox(width: 10),
                Text(header, style: AppTheme.headerTextStyle)
              ],
            )
          ),
          (subHeader.isEmpty) ? null :
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 10),
                  Flexible(child:Text(subHeader, style: AppTheme.subHeaderTextStyle))
                ],
              )
            )
        ],
      )
    );
  }
}