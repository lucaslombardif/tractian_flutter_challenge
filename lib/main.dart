import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/route_manager.dart';

import 'modules/companies/presentation/pages/companies_page.dart';
import 'modules/company_assets/presentation/pages/assets_list_page.dart';
import 'shared/infra/injection/dependency_injection.dart';
import 'shared/presentation/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/home',
      initialBinding: DependencyInjection(),
      getPages: [
        GetPage(name: '/home', page: () => const CompaniesPage()),
        GetPage(name: '/assets', page: () => const AssetsListPage()),
      ],
    );
  }
}
