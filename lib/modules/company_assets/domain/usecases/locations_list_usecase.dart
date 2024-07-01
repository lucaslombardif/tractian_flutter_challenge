import '../../infra/repositories/locations_list_repository.dart';
import '../entities/location_entity.dart';
import 'interfaces/locations_list_usecase_interface.dart';

class LocationsListUsecase implements LocationsListUsecaseInterface {
  final LocationsListRepository _locationsListRepository;

  LocationsListUsecase(
      {required LocationsListRepository locationsListRepository})
      : _locationsListRepository = locationsListRepository;

  @override
  Future<List<LocationEntity>> call(String companyId) async {
    return await _locationsListRepository.getLocations(companyId);
  }
}
