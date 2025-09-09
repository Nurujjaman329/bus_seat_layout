import '../entities/bus_layout_entity.dart';

abstract class BusLayoutRepository {
  Future<BusLayoutEntity> getBusLayoutFromApi1();
  Future<BusLayoutEntity> getBusLayoutFromApi2();
}