import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tractian_flutter_challenge/shared/presentation/theme/app_icons.dart';

import '../controllers/companies_controller.dart';
import '../widgets/company_card_widget.dart';

class CompaniesPage extends GetView<CompaniesController> {
  const CompaniesPage({super.key});
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          AppIcons.logo,
          height: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: controller.obx(
          (companies) => ListView.builder(
            itemCount: companies!.length,
            itemBuilder: (context, index) => CompanyCardWidget(
              company: companies[index],
              onTap: () => onTap(companies[index].id),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(String companyId) {
    Get.toNamed('/assets', parameters: {'companyId': companyId});
  }
}
