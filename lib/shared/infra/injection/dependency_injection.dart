import 'package:get/get.dart';

import '../../../modules/companies/domain/usecases/companies_list_usecase.dart';
import '../../../modules/companies/domain/usecases/interfaces/companies_list_usecase_interface.dart';
import '../../../modules/companies/infra/repositories/companies_list_repository.dart';
import '../../../modules/companies/presentation/controllers/companies_controller.dart';
import '../../../modules/company_assets/domain/usecases/assets_list_usecase.dart';
import '../../../modules/company_assets/domain/usecases/interfaces/assets_list_usecase_interface.dart';
import '../../../modules/company_assets/domain/usecases/interfaces/locations_list_usecase_interface.dart';
import '../../../modules/company_assets/domain/usecases/locations_list_usecase.dart';
import '../../../modules/company_assets/infra/repositories/assets_list_repository.dart';
import '../../../modules/company_assets/infra/repositories/locations_list_repository.dart';
import '../../../modules/company_assets/presentation/controllers/assets_controller.dart';
import '../services/http_service.dart';

class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.put<HttpService>(HttpService());

    Get.put<CompaniesListRepository>(
      CompaniesListRepository(
        httpService: Get.find<HttpService>(),
      ),
    );

    Get.put<CompaniesListUsecaseInterface>(CompaniesListUsecase(
        companiesListRepository: Get.find<CompaniesListRepository>()));

    Get.put<CompaniesController>(
      CompaniesController(
          companiesListUseCase: Get.find<CompaniesListUsecaseInterface>()),
    );

    Get.put<AssetsListRepository>(
        AssetsListRepository(httpService: Get.find<HttpService>()));

    Get.put<AssetsListUsecaseInterface>(
      AssetsListUsecase(
        getAssetsRepository: Get.find<AssetsListRepository>(),
      ),
    );

    Get.put<LocationsListRepository>(
        LocationsListRepository(httpService: Get.find<HttpService>()));

    Get.put<LocationsListUsecaseInterface>(LocationsListUsecase(
        locationsListRepository: Get.find<LocationsListRepository>()));

    Get.put<AssetsController>(
      AssetsController(
          assetsListUsecase: Get.find<AssetsListUsecaseInterface>(),
          locationsListUsecase: Get.find<LocationsListUsecaseInterface>()),
    );
  }
}
