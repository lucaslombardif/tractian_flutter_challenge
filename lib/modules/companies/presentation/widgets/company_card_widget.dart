import 'package:flutter/material.dart';

import '../../domain/entities/company_entity.dart';

class CompanyCardWidget extends StatelessWidget {
  const CompanyCardWidget({
    super.key,
    required this.onTap,
    required this.company,
  });

  final void Function() onTap;
  final CompanyEntity company;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 85,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 8,
                spreadRadius: 1,
              )
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: Color(0xFF127CD3),
          ),
          child: Center(
            child: Row(
              children: [
                const SizedBox(width: 30),
                const Icon(
                  Icons.room_preferences,
                  size: 30,
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                Text(
                  '${company.name} Unit',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
