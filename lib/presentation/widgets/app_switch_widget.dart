// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/colors.dart';

class AppSwitch extends StatelessWidget {
  final RxBool value;
  final Function(bool)? onChanged;

  const AppSwitch({required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          value.value = !value.value;
          onChanged!(value.value);
        }
      },
      child: Obx(
        () => Container(
          width: 48,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: value.value
                ? AppColors.primary200
                : Theme.of(context).brightness == Brightness.dark
                ? AppColors.grey500
                : Colors.grey[300],
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                left: value.value ? 24 : 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.grey300),
                    shape: BoxShape.circle,
                    color: onChanged != null
                        ? Colors.white
                        : const Color.fromARGB(247, 193, 192, 192),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
