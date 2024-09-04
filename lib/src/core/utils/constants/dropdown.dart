import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';

import 'app_colors.dart';

class AppDropdownInput extends ConsumerWidget {
  final String hintText;
  final List<String> options;
  final String? value;
  final String text;

  final void Function(String?)? onChanged;

  const AppDropdownInput({
    super.key,
    required this.hintText,
    this.options = const [],
    required this.value,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var darkMode = ref.watch(darkModeProvider);
    return FormField<String>(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.textGreyColor,
                  width: 0.8,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.textGreyColor,
                  width: 0.8,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.textGreyColor,
                  width: 0.8,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 0.8,
                ),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                color: AppColors.textGreyColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.textGreyColor,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an Option';
              }
              return null;
            },
            hint: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGreyColor,
                  ),
            ),
            value: value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
            icon: const Icon(
              CupertinoIcons.chevron_down,
              size: 15,
            ),
            isDense: true,
            onChanged: onChanged,
            dropdownColor: AppColors.lightGreen,
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
