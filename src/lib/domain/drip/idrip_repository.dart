import 'package:mediadrip/domain/drip/drip.dart';

class IDripRepository {
  void addDrip(Drip drip) => throw Exception('Not implemented.');
  void addDrips(List<Drip> drips) => throw Exception('Not implemented.');
  List<Drip> getAllDrips() => throw Exception('Not implemented.');
  void orderDripsByDateDescending() => throw Exception('Not implemented.');
  void removeDripsExceedingMaxCount(int count) => throw Exception('Not implemented.');
  int count() => throw Exception('Not implemented.');
}