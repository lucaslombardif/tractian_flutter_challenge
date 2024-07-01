import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/presentation/controllers/assets_controller.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/presentation/widgets/tree_node_widget.dart';

class AssetsListPage extends GetView<AssetsController> {
  const AssetsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final companyId = Get.parameters['companyId'];
    controller.getLocationsAndAssets(companyId!);

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Assets',
        style: TextStyle(fontSize: 18),
      )),
      body: controller.obx(
        (state) {
          if (controller.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.status.isError) {
            return Center(
                child: Text('Error: ${controller.status.errorMessage}'));
          } else {
            return TreeNodeWidget(
              locations: controller.locationsFormatted,
              assets: controller.assets,
            );
          }
        },
      ),
    );
  }
}
