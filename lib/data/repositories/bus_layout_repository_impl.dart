

import 'package:bus_seat_layout/core/error/failures.dart';
import 'package:bus_seat_layout/data/datasources/bus_layout_remote_data_source.dart';
import 'package:bus_seat_layout/domain/entities/bus_layout_entity.dart';
import 'package:bus_seat_layout/domain/repositories/bus_layout_repository.dart';

class BusLayoutRepositoryImpl implements BusLayoutRepository {
  final BusLayoutRemoteDataSource remoteDataSource;

  BusLayoutRepositoryImpl({required this.remoteDataSource});

  @override
  Future<BusLayoutEntity> getBusLayoutFromApi1() async {
    try {
      final model = await remoteDataSource.getBusLayoutFromApi1();
      return BusLayoutEntity(data: model.data);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BusLayoutEntity> getBusLayoutFromApi2() async {
    try {
      final model = await remoteDataSource.getBusLayoutFromApi2();
      return BusLayoutEntity(data: model.data);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Unexpected error: ${e.toString()}');
    }
  }
}