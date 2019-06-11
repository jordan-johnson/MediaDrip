import '../widgets/page/dripPage.dart';
import 'util/pageWrapper.dart';

class ToolsPage extends StatefulDripPage {
  @override
  String get title => 'Video Tools';

  @override
  String get route => '/tools';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: this.title,
      body: Text(
        'video tools!!!',
        style: Theme.of(context).textTheme.display1
      )
    );
  }
}