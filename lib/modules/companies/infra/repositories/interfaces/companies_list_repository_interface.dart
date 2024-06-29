import '../../../domain/entities/company_entity.dart';

abstract class CompaniesListRepositoryInterface { 
  Future<List<CompanyEntity>> getAll(); 
}