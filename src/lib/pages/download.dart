import '../widgets/page/dripPage.dart';
import 'util/pageWrapper.dart';

class DownloadPage extends DripPage {
  @override
  String get title => 'Download';

  @override
  String get route => '/download';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: this.title,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Please enter a URL...'
            ),
          ),
          RaisedButton(
            child: Text('Download'),
            onPressed: () => null
          )
        ]
      )
    );
  }
}