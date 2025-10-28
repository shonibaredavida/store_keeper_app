import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/textstyles.dart';

class AppTextFormField extends HookWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool hasError;
  final Function(String)? onChanged;
  final EdgeInsets? contentPadding;
  final int? minLines;
  final int? maxLines;
  final bool isNumberInput;
  final bool onlyIntInput;
  final int? maxLenght;
  final Widget? prefixIcon;
  final Color? borderColor;
  final bool? isfilled;
  final List<TextInputFormatter>? inputFormat;
  final bool isPasswordField;
  final double? borderWidth;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;

  const AppTextFormField({
    this.inputFormat,
    this.contentPadding,
    this.maxLenght,
    this.minLines,
    this.maxLines,
    this.isNumberInput = false,
    this.onlyIntInput = false,
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.hasError = false,
    this.onChanged,
    this.isPasswordField = false,
    this.borderWidth,
    this.focusNode,
    this.onFieldSubmitted,
    this.borderColor,
    this.isfilled,
  });

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(color: color, width: borderWidth ?? 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final obscure = useState(isPasswordField);

    return TextFormField(
      minLines: minLines,
      maxLength: maxLenght,
      maxLines: maxLines ?? 1,
      inputFormatters: inputFormat ?? [],
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      onChanged: onChanged,
      keyboardType: isNumberInput
          ? TextInputType.numberWithOptions(
              decimal: onlyIntInput ? false : true,
            )
          : TextInputType.name,
      validator: validator,
      obscureText: obscure.value,
      decoration: InputDecoration(
        fillColor: AppColors.grey50,
        filled: isfilled ?? false,
        hintText: hintText,
        counterText: '',
        hintStyle: AppTextStyles.captionSm.copyWith(color: AppColors.grey300),
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        suffixIcon: isPasswordField
            ? IconButton(
                icon: Icon(
                  obscure.value ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grey300,
                ),
                onPressed: () => obscure.value = !obscure.value,
              )
            : null,
        border: _border(
          hasError ? AppColors.alert300 : borderColor ?? AppColors.grey100,
        ),
        enabledBorder: _border(
          hasError ? AppColors.alert300 : borderColor ?? AppColors.grey100,
        ),
        focusedBorder: _border(
          hasError ? AppColors.alert300 : borderColor ?? AppColors.primaryColor,
        ),
        errorBorder: _border(AppColors.alert300),
        focusedErrorBorder: _border(AppColors.alert300),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
