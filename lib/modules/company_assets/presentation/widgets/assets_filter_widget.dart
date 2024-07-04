import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/assets_controller.dart';

class AssetsFilterWidget extends StatelessWidget {
  final AssetsController controller;

  const AssetsFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // Campo de pesquisa
          Container(
            constraints: const BoxConstraints(maxHeight: 34),
            child: TextField(
              controller: textEditingController,
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.justify,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar Ativo ou Local',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.8)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0)),
              ),
              onChanged: (value) {
                controller.filterText.value = value;
                controller.applyFilters();
              },
            ),
          ),
          const SizedBox(height: 8.0),

          // Filtros de energia e crítico
          Row(
            children: [
              // Filtro de energia
              Expanded(
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      controller.filterEnergy.value =
                          !controller.filterEnergy.value;
                      controller.applyFilters();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: controller.filterEnergy.value
                            ? Colors.blue
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.bolt, color: Colors.black, size: 20),
                          SizedBox(width: 8.0),
                          Text('Sensor de Energia',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),

              // Filtro crítico
              Expanded(
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      controller.filterCritical.value =
                          !controller.filterCritical.value;
                      controller.applyFilters();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: controller.filterCritical.value
                            ? Colors.blue
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning, color: Colors.black, size: 20),
                          SizedBox(width: 8.0),
                          Text('Crítico',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(height: 4),
        ],
      ),
    );
  }
}
