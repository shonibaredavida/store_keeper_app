import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/colors.dart';
import '../controllers/create_product_controller.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.controller,
    required this.imageHeight,
  });
  final double imageHeight;
  final CreateProductController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        clipBehavior: Clip.hardEdge,
        width: imageHeight,
        height: imageHeight,
        decoration: BoxDecoration(
          color: AppColors.primary50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.file(File(controller.imagePath.value), fit: BoxFit.fill),
      ),
    );
  }
}
