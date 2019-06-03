import '../widgets/page/dripPage.dart';
import 'util/pageWrapper.dart';

class ToolsPage extends DripPage {
  @override
  String get route => '/tools';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: Text(
        'video tools!!!',
        style: Theme.of(context).textTheme.display1
      )
    );
  }
}