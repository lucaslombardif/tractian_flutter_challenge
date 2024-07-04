import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/assets_controller.dart';
import '../widgets/assets_filter_widget.dart';
import '../widgets/tree_node_widget.dart';

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
    body: Column(
        children: [
          // Adicione o widget de filtros
          AssetsFilterWidget(controller: controller),
          Expanded(
            child: controller.obx(
              (state) {
                if (controller.status.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.status.isError) {
                  return Center(
                      child: Text('Error: ${controller.status.errorMessage}'));
                } else {
                  return TreeNodeWidget(
                    locations: controller.filteredLocations,
                    assets: controller.filteredAssets,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
