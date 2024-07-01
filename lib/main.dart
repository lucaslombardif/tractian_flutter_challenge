import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/route_manager.dart';
import 'package:tractian_flutter_challenge/modules/companies/presentation/pages/companies_page.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/presentation/pages/assets_list_page.dart';
import 'package:tractian_flutter_challenge/shared/infra/injection/dependency_injection.dart';
import 'package:tractian_flutter_challenge/shared/presentation/theme/theme.dart';
//import 'package:tractian_flutter_challenge/shared/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/home',
      initialBinding: DependencyInjection(),
      getPages: [
        GetPage(name: '/home', page: () => const CompaniesPage()),
        GetPage(name: '/assets', page: () => const AssetsListPage()),
      ],
      //theme: appTheme,
    );
  }
}
