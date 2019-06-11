import '../widgets/page/dripPage.dart';
import 'util/pageWrapper.dart';

class HomePage extends StatelessDripPage {
  @override
  String get title => '';

  @override
  String get route => '/';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      enableDrawer: true,
      body: DripAssets.image('mediaDripLogo.png', 512, 128)
    );
  }
}