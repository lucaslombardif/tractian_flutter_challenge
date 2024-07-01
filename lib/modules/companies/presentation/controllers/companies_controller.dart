import 'package:get/get.dart';

import '../../domain/entities/company_entity.dart';
import '../../domain/usecases/interfaces/companies_list_usecase_interface.dart';

class CompaniesController extends GetxController
    with StateMixin<List<CompanyEntity>> {
  final CompaniesListUsecaseInterface _companiesListUseCase;

  CompaniesController(
      {required CompaniesListUsecaseInterface companiesListUseCase})
      : _companiesListUseCase = companiesListUseCase;

  @override
  void onInit() {
    _getAllCompanies();
    super.onInit();
  }

  Future<void> _getAllCompanies() async {
    late final List<CompanyEntity> companies;
    try {
      companies = await _companiesListUseCase();
    } catch (e) {
      companies = [];
      change(
        companies,
        status: RxStatus.error(
          e.toString(),
        ),
      );
    } finally {
      change(companies, status: RxStatus.success());
    }
  }
}
