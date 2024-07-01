import '../../../domain/entities/location_entity.dart';

abstract class LocationsListRepositoryInterface {
  Future<List<LocationEntity>> getLocations(String companyId);
}
