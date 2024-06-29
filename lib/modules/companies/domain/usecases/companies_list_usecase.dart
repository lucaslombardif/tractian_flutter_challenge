

import '../../infra/repositories/companies_list_repository.dart';
import '../entities/company_entity.dart';
import 'interfaces/companies_list_usecase_interface.dart';

class CompaniesListUsecase implements CompaniesListUsecaseInterface {
  final CompaniesListRepository _companiesListRepository;

  CompaniesListUsecase(
      {required CompaniesListRepository companiesListRepository})
      : _companiesListRepository = companiesListRepository;

  @override
  Future<List<CompanyEntity>> call() async{
    return await _companiesListRepository.getAll();
  }
}
