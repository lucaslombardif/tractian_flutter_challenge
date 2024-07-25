import 'dart:isolate';

import '../../../../shared/infra/services/http_service.dart';
import '../../domain/entities/company_entity.dart';
import 'interfaces/companies_list_repository_interface.dart';

class CompaniesListRepository implements CompaniesListRepositoryInterface {
  final HttpService _httpService;

  CompaniesListRepository({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<List<CompanyEntity>> getAll() async {
    final response = await _httpService.get('/companies');
    final allCompanies = await Isolate.run<List<CompanyEntity>>(() {
      final List<CompanyEntity> companies = (response.data as List)
          .map((company) => CompanyEntity.fromJson(company))
          .toList();
      return companies;
    });
    return allCompanies;
  }
}
