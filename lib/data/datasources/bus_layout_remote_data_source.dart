import 'dart:async';
import 'dart:convert';

import 'package:bus_seat_layout/core/error/failures.dart';
import 'package:bus_seat_layout/data/models/bus_layout_model.dart';
import 'package:http/http.dart' as http;

abstract class BusLayoutRemoteDataSource {
  Future<BusLayoutModel> getBusLayoutFromApi1();
  Future<BusLayoutModel> getBusLayoutFromApi2();
}

class BusLayoutRemoteDataSourceImpl implements BusLayoutRemoteDataSource {
  final http.Client client;

  BusLayoutRemoteDataSourceImpl({required this.client});

  @override
  Future<BusLayoutModel> getBusLayoutFromApi1() async {
    try {
      final response = await client.get(
        Uri.parse('https://api.jsonbin.io/v3/b/68b7cce7d0ea881f407010d6'),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return BusLayoutModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw const ServerFailure('API 1 endpoint not found');
      } else if (response.statusCode >= 500) {
        throw const ServerFailure('Server error occurred with API 1');
      } else {
        throw ServerFailure('Failed to load bus layout from API 1: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw NetworkFailure('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw DataParsingFailure('Invalid data format from API 1: ${e.message}');
    } on TimeoutException catch (_) {
      throw const NetworkFailure('Request to API 1 timed out');
    } catch (e) {
      throw UnknownFailure('Unexpected error with API 1: ${e.toString()}');
    }
  }

  @override
  Future<BusLayoutModel> getBusLayoutFromApi2() async {
    try {
      final response = await client.get(
        Uri.parse('https://api.jsonbin.io/v3/b/68bd5016ae596e708fe58eb1'),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return BusLayoutModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw const ServerFailure('API 2 endpoint not found');
      } else if (response.statusCode >= 500) {
        throw const ServerFailure('Server error occurred with API 2');
      } else {
        throw ServerFailure('Failed to load bus layout from API 2: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw NetworkFailure('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw DataParsingFailure('Invalid data format from API 2: ${e.message}');
    } on TimeoutException catch (_) {
      throw const NetworkFailure('Request to API 2 timed out');
    } catch (e) {
      throw UnknownFailure('Unexpected error with API 2: ${e.toString()}');
    }
  }
}