import '../widgets/page/dripPage.dart';
import 'util/pageWrapper.dart';
import '../tools/downloader.dart';

class DownloadPage extends StatefulDripPage {
  @override
  String get title => 'Download';

  @override
  String get route => '/download';

  final downloadTool = Downloader();
  //final urlController = TextEditingController();

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
            )
          ),
          RaisedButton(
            child: Text('Download'),
            onPressed: () => downloadTool.run()
          )
        ]
      )
    );
  }
}