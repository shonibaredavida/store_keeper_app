import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.customChild,
    this.buttonColor = AppColors.primaryColor,
    this.labelColor = AppColors.whiteColor,
    this.disabledColor,
    this.labelTextStyle,
    this.borderColor,
    this.isCollapsed = false,
    this.isBusy = false,
    this.isDisabled = false,
    this.showFeedback = true,
    this.elevation = 0,
    this.fontWeight,
    this.borderRadius = 100,
    this.padding,
    this.labelSize = 16,
    this.prefixWidget,
    this.suffixWidget,
    this.prefixPadding = 16,
    this.suffixPadding = 10,
  }) : hasBorder = false,
       isTextButton = false;

  const AppButton.outline({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.customChild,
    this.buttonColor = AppColors.transparent,
    this.labelColor = AppColors.grey100,
    this.labelTextStyle,
    this.disabledColor,
    this.borderColor = AppColors.grey100,
    this.isCollapsed = false,
    this.isBusy = false,
    this.isDisabled = false,
    this.showFeedback = true,
    this.elevation = 0,
    this.fontWeight,
    this.borderRadius = 100,
    this.padding,
    this.labelSize = 14,
    this.prefixWidget,
    this.suffixWidget,
    this.prefixPadding = 16,
    this.suffixPadding = 10,
  }) : hasBorder = true,
       isTextButton = false;

  const AppButton.textButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.customChild,
    this.buttonColor = AppColors.transparent,
    this.labelColor = AppColors.primaryColor,
    this.labelTextStyle,
    this.disabledColor,
    this.borderColor = AppColors.grey100,
    this.isCollapsed = false,
    this.isBusy = false,
    this.isDisabled = false,
    this.showFeedback = false,
    this.elevation = 0,
    this.fontWeight = FontWeight.w500,
    this.borderRadius = 100,
    this.padding = const EdgeInsets.all(0),
    this.labelSize = 16,
    this.prefixWidget,
    this.suffixWidget,
    this.prefixPadding = 16,
    this.suffixPadding = 10,
  }) : hasBorder = false,
       isTextButton = true;

  final String? label;
  final VoidCallback? onPressed;
  final TextStyle? labelTextStyle;
  final Color labelColor;
  final Color buttonColor;
  final Color? borderColor;
  final Color? disabledColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final double? labelSize;
  final double? elevation;
  final bool isCollapsed;
  final bool isDisabled;
  final bool hasBorder;
  final bool isBusy;
  final bool showFeedback;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final Widget? customChild;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final double prefixPadding;
  final double suffixPadding;
  final bool isTextButton;

  @override
  Widget build(BuildContext context) {
    if (isTextButton) {
      return MaterialButton(
        onPressed: isDisabled ? null : () => isBusy ? null : onPressed?.call(),
        disabledColor: disabledColor ?? Color(0xFFEFE6E8),
        color: buttonColor,
        minWidth: 0,
        elevation: elevation,
        clipBehavior: Clip.hardEdge,
        splashColor: showFeedback ? null : buttonColor,
        highlightColor: showFeedback ? null : buttonColor,
        highlightElevation: showFeedback ? 4 : 0,
        padding: padding ?? const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Builder(
          builder: (context) {
            if (customChild != null) {
              return Align(
                alignment: Alignment.centerLeft,
                child: customChild!,
              );
            }

            return FittedBox(
              child: Row(
                children: [
                  if (prefixWidget != null)
                    Padding(
                      padding: EdgeInsets.only(right: prefixPadding),
                      child: prefixWidget,
                    ),
                  Center(
                    child: Text(
                      label!,
                      style:
                          labelTextStyle ??
                          TextStyle(
                            color: isDisabled ? Color(0xFFB8B9BA) : labelColor,
                            fontSize: labelSize,
                            fontWeight: fontWeight,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (suffixWidget != null)
                    Padding(
                      padding: EdgeInsets.only(left: suffixPadding),
                      child: suffixWidget,
                    ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return SizedBox(
        width: width ?? (isCollapsed ? null : double.maxFinite),
        height: height ?? (isCollapsed ? null : 45),
        child: MaterialButton(
          onPressed: isDisabled
              ? null
              : () => isBusy ? null : onPressed?.call(),
          disabledColor: disabledColor ?? Color(0xFFEFE6E8),
          color: buttonColor,
          minWidth: 0,
          elevation: elevation,
          clipBehavior: Clip.hardEdge,
          splashColor: showFeedback ? null : buttonColor,
          highlightColor: showFeedback ? null : buttonColor,
          highlightElevation: showFeedback ? 4 : 0,
          padding: padding ?? const EdgeInsets.fromLTRB(16, 10, 16, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: hasBorder ? BorderSide(color: borderColor!) : BorderSide.none,
          ),
          child: Builder(
            builder: (context) {
              if (customChild != null) return customChild!;

              return FittedBox(
                child: Row(
                  children: [
                    if (prefixWidget != null)
                      Padding(
                        padding: EdgeInsets.only(right: prefixPadding),
                        child: prefixWidget,
                      ),
                    Center(
                      child: Text(
                        label!,
                        style:
                            labelTextStyle ??
                            TextStyle(
                              color: isDisabled
                                  ? Color(0xFFB8B9BA)
                                  : labelColor,
                              fontSize: labelSize,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (suffixWidget != null)
                      Padding(
                        padding: EdgeInsets.only(left: suffixPadding),
                        child: suffixWidget,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
