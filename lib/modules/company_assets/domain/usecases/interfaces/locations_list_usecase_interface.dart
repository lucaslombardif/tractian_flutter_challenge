import '../../entities/location_entity.dart';

abstract class LocationsListUsecaseInterface {
  Future<List<LocationEntity>> call(String companyId);
}
