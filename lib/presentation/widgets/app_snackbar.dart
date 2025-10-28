import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/textstyles.dart';

SnackbarController appSnackBar(
  String messageString, {
  double? width,
  SnackPosition? snackPosition = SnackPosition.BOTTOM,
}) {
  return Get.rawSnackbar(
    messageText: Text(
      messageString,
      style: AppTextStyles.captionMd.copyWith(color: AppColors.primaryColor),
      textAlign: TextAlign.center,
    ),
    borderColor: AppColors.primaryColor,
    borderRadius: 100,
    borderWidth: 2,
    maxWidth: width ?? double.infinity,
    duration: const Duration(seconds: 2),
    backgroundColor: AppColors.whiteColor,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    snackPosition: snackPosition!,
  );
}
