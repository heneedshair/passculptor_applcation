import 'package:code_generator_app/common/objects/code_generator/code_generator_types.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class AlgorithmDropdownWidget extends StatelessWidget {
  const AlgorithmDropdownWidget({
    super.key,
    required this.onEncryptionAlgorithmChanged,
    required this.encryptionAlgorithmList,
    required this.encryptionAlgorithmListenable,
  });

  final Function(String? selectedValue) onEncryptionAlgorithmChanged;
  final List<String> encryptionAlgorithmList;
  final ValueNotifier<EntityState<EncryptionType>>
      encryptionAlgorithmListenable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appBarColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: EntityStateNotifierBuilder(
        listenableEntityState: encryptionAlgorithmListenable,
        builder: (_, encryptionType) => encryptionType == null
            ? const SizedBox.shrink()
            : DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: encryptionType.name,
                  items: encryptionAlgorithmList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: onEncryptionAlgorithmChanged,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
              ),
      ),
    );
  }
}
