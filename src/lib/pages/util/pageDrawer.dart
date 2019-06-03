import '../../widgets/navigation/drawer/dripDrawer.dart';

class PageDrawer extends DripDrawer {
  @override
  Widget build(BuildContext context) {
    return DripDrawer(
      items: <DripDrawerItem>[
        DripDrawerItem(label: 'Home', route: '/', icon: Icons.home),
        DripDrawerItem(label: 'Download', route: '/download', icon: Icons.arrow_downward),
        DripDrawerItem(label: 'Video Tools', route: '/tools', icon: Icons.video_library),
        DripDrawerItem(label: 'Settings', route: '/settings', icon: Icons.settings)
      ]
    );
  }
}