import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store_keeper_app/models/product_model.dart';
import 'package:store_keeper_app/presentation/widgets/app_snackbar.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/textstyles.dart';
import '../controllers/create_product_controller.dart';
import '../widgets/app_button_widget.dart';
import '../widgets/app_text_field.dart';
import '../widgets/profile_image_widget.dart';

class CreateProductSheet extends StatelessWidget {
  CreateProductSheet({super.key, this.product});
  final controller = Get.put(CreateProductController());
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    bool editMode = false;
    if (product != null) {
      controller.updateFields(product);
      editMode = true;
    }
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.blackColor
                  : AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            editMode
                                ? 'Update Product Information'
                                : 'Add New Product',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.captionLg.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.resetField();
                            Get.back();
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Product Name',
                              style: AppTextStyles.bodySm,
                            ),
                          ),
                          Obx(
                            () => AppTextFormField(
                              hintText: 'Enter Product Name',
                              controller: controller.nameController,
                              hasError: controller.hasNameError.value,
                              onChanged: (val) => controller.name.value = val,
                            ),
                          ),

                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Quantity',
                                  style: AppTextStyles.bodySm,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  ' Unit',
                                  style: AppTextStyles.bodySm,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Obx(
                                  () => AppTextFormField(
                                    hintText: 'Enter Quantity of Product',
                                    inputFormat: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    controller: controller.quantityController,
                                    isNumberInput: true,
                                    onlyIntInput: true,
                                    hasError: controller.hasQuantityError.value,
                                    onChanged: (val) {
                                      controller.quantity.value = val;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: DropdownButtonFormField<String>(
                                  initialValue:
                                      controller.selectedMeasure.value,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  items: controller.measurement.map((
                                    String item,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    controller.selectedMeasure.value =
                                        val ?? '';
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Price (N)',
                              style: AppTextStyles.bodySm,
                            ),
                          ),
                          Obx(
                            () => AppTextFormField(
                              hintText: 'Enter Price of Product',
                              inputFormat: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*$'),
                                ),
                              ],
                              controller: controller.priceController,
                              onlyIntInput: false,
                              hasError: controller.hasPriceError.value,
                              isNumberInput: true,
                              onChanged: (val) {
                                controller.price.value = val;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          Obx(
                            () => Align(
                              alignment: Alignment.center,
                              child: controller.imagePath.value.isNotEmpty
                                  ? Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ProductImage(
                                            controller: controller,
                                            imageHeight: 320,
                                          ),
                                        ),
                                        Positioned(
                                          right: 3,
                                          top: 0,
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color:
                                                Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? AppColors.blackColor
                                                : AppColors.grey50,
                                            size: 32,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: GestureDetector(
                                            onTap: controller.cancelImage,
                                            child: Icon(
                                              Icons.cancel_outlined,
                                              size: 32,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 37,
                                          top: 0,
                                          child: Icon(
                                            Icons.edit,
                                            color:
                                                Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? AppColors.blackColor
                                                : AppColors.grey50,
                                            size: 32,
                                          ),
                                        ),
                                        Positioned(
                                          right: 40,
                                          top: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.pickImage();
                                            },
                                            child: Icon(Icons.edit, size: 32),
                                          ),
                                        ),
                                      ],
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.pickImage();
                                      },
                                      child: Text(
                                        'Click to upload image',
                                        style: AppTextStyles.bodySm,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => AppButton(
                              onPressed: () {
                                controller.createProduct(editMode);
                                Get.back();
                                appSnackBar(
                                  editMode
                                      ? 'Product information updated'
                                      : 'New Product Created',
                                  snackPosition: SnackPosition.TOP,
                                );
                                controller.resetField();
                              },
                              label: editMode
                                  ? 'Update Product'
                                  : 'Create Product',
                              isDisabled:
                                  controller.name.value.isEmpty ||
                                  controller.quantity.value.isEmpty ||
                                  controller.price.value.isEmpty,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
