import 'dart:isolate';

import '../../../../shared/infra/services/http_service.dart';
import '../../domain/entities/location_entity.dart';
import 'interfaces/locations_list_repository_interface.dart';

class LocationsListRepository implements LocationsListRepositoryInterface {
  final HttpService _httpService;

  LocationsListRepository({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<List<LocationEntity>> getLocations(String companyId) async {
    final response = await _httpService.get('/companies/$companyId/locations');
    final allLocations = await Isolate.run<List<LocationEntity>>(() {
      final List<LocationEntity> locations = (response.data as List)
          .map((asset) => LocationEntity.fromJson(asset))
          .toList();
      return locations;
    });
    return allLocations;
  }
}
