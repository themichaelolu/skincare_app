import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';

class SmallDropdownWidget extends StatefulWidget {
  const SmallDropdownWidget({
    super.key,
    this.width,
    required this.items,
    this.onChanged,
    this.value,
    this.hint,
  });

  final double? width;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String? value;
  final String? hint;

  @override
  State<SmallDropdownWidget> createState() => _SmallDropdownWidgetState();
}

class _SmallDropdownWidgetState extends State<SmallDropdownWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
            hint: Text(widget.hint ?? '', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGreyColor,
            ),),
            isExpanded: true,
            underline: const SizedBox(),
            value: widget.value,
            items: widget.items,
            onChanged: widget.onChanged,
            icon: const Icon(Icons.expand_more)),
      ),
    );
  }
}
