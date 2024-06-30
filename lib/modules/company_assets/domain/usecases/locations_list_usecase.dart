import 'package:tractian_flutter_challenge/modules/company_assets/domain/entities/location_entity.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/domain/usecases/interfaces/locations_list_usecase_interface.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/infra/repositories/locations_list_repository.dart';

class LocationsListUsecase implements LocationsListUsecaseInterface {
  final LocationsListRepository _locationsListRepository;

  LocationsListUsecase({required LocationsListRepository locationsListRepository})
      : _locationsListRepository = locationsListRepository;

  @override
  Future<List<LocationEntity>> call(String companyId) async {
    return await _locationsListRepository.getLocations(companyId);
  }
}
