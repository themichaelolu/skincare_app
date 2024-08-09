import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';

import '../app_assets/app_assets.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPasswordField = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.enabled,
    this.readOnly = false,
    this.filled,
    this.fillColor,
    this.inputFormatters,
    this.onSaved,
    this.onChanged,
  });

  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordField;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;


  final bool? enabled;
  final bool readOnly;
  final String? labelText;
  final bool? filled;
  final Color? fillColor;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = true;
  var _focusNode = FocusNode();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onOnFocusNodeEvent() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onOnFocusNodeEvent);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText ?? '',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        5.h.verticalSpace,
        TextFormField(
          validator: widget.validator,
          onSaved: widget.onSaved,
          enabled: widget.enabled,
          maxLines: 1,
          readOnly: widget.readOnly,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscuringCharacter: '●',
          obscureText: widget.isPasswordField ? _obscureText : false,
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            filled: widget.filled,
            suffixIcon: widget.isPasswordField
                ? PasswordSuffixWidget(
                    obscureText: _obscureText,
                    onPressed: _toggle,
                  )
                : widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGreyColor,
                ),
            focusColor: null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.textGreyColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.textGreyColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: AppColors
                    .textGreyColor, //const Color(0xffEC7536).withOpacity(0.3),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: AppColors.textGreyColor,
                width: 0.8,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 0.8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordSuffixWidget extends StatelessWidget {
  const PasswordSuffixWidget({
    super.key,
    required this.onPressed,
    required this.obscureText,
  });

  final void Function() onPressed;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 25,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Align(
        widthFactor: 1,
        heightFactor: 1,
        child: SvgPicture.asset(
          obscureText ? AppAssets.eyeIcon : AppAssets.eyeIcon,
        ),
      ),
    );
  }
}
