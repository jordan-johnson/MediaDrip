import '../widgets/page/dripPage.dart';
import 'util/pageWrapper.dart';

class SettingsPage extends StatefulDripPage {
  @override
  String get title => 'Settings';

  @override
  String get route => '/settings';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: this.title,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Source Configuration Files',
            style: Theme.of(context).textTheme.headline
          ),
          Divider(color: Colors.deepPurple),
          Table(
            border: TableBorder.all(width: 1.0, color: Colors.black),
            children: <TableRow>[
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Text>[
                        Text('Youtube'),
                        Text('Jordan Johnson')
                      ],
                    )
                  )
                ]
              ),
              TableRow(
                children: <TableCell>[
                  TableCell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Text>[
                        Text('SoundCloud'),
                        Text('Jordan Johnson')
                      ],
                    )
                  )
                ]
              )
            ],
          )
        ],
      )
    );
  }
}