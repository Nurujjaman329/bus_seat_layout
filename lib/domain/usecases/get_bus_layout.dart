import '../entities/bus_layout_entity.dart';
import '../repositories/bus_layout_repository.dart';

class GetBusLayout {
  final BusLayoutRepository repository;

  GetBusLayout({required this.repository});

  Future<BusLayoutEntity> fromApi1() async {
    return await repository.getBusLayoutFromApi1();
  }

  Future<BusLayoutEntity> fromApi2() async {
    return await repository.getBusLayoutFromApi2();
  }
}