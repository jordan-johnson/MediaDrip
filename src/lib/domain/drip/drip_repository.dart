import 'package:mediadrip/domain/drip/drip.dart';
import 'package:mediadrip/domain/drip/idrip_repository.dart';

class DripRepository implements IDripRepository {
  final List<Drip> _drips = <Drip>[];

  void addDrip(Drip drip) {
    _drips.add(drip);
  }

  void addDrips(List<Drip> drips) {
    _drips.addAll(drips);
  }

  List<Drip> getAllDrips() {
    return _drips;
  }

  void deleteAllDrips() {
    _drips.clear();
  }

  void orderDripsByDateDescending() {
    if(_drips == null || _drips.isEmpty)
      return;
    
    _drips.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  void removeDripsExceedingMaxCount(int count) {
    if(_drips == null || _drips.isEmpty)
      return;

    if(_drips.length > count) {
      _drips.removeRange(count, _drips.length);
    }
  }

  int count() {
    return _drips?.length ?? 0;
  }
}