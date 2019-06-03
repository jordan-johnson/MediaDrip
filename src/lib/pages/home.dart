import '../widgets/page/dripPage.dart';
import 'util/pageWrapper.dart';

class HomePage extends DripPage {
  @override
  String get route => '/';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      enableDrawer: true,
      body: Text(
        'this is the home page!',
        style: Theme.of(context).textTheme.display1
      )
    );
  }
}