import '../../entities/company_entity.dart';

abstract class CompaniesListUsecaseInterface { 
  Future<List<CompanyEntity>> call();
}