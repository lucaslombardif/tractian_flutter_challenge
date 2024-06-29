import 'package:get/get.dart';
import 'package:tractian_flutter_challenge/modules/companies/domain/usecases/companies_list_usecase.dart';
import 'package:tractian_flutter_challenge/modules/companies/domain/usecases/interfaces/companies_list_usecase_interface.dart';
import 'package:tractian_flutter_challenge/modules/companies/infra/repositories/companies_list_repository.dart';
import 'package:tractian_flutter_challenge/modules/companies/presentation/controllers/companies_controller.dart';

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
  }
}
