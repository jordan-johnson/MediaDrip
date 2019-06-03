import '../widgets/page/dripPage.dart';
import 'util/pageWrapper.dart';

class SettingsPage extends DripPage {
  @override
  String get route => '/settings';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: Text(
        'some settings!',
        style: Theme.of(context).textTheme.display1
      )
    );
  }
}