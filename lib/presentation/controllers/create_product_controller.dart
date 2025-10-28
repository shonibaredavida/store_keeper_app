import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_keeper_app/presentation/controllers/home_screen_controller.dart';
import 'package:store_keeper_app/utils/constants/colors.dart';
import 'package:store_keeper_app/utils/constants/validation.dart';

import '../../models/product_model.dart';

class CreateProductController extends GetxController {
  RxString name = ''.obs;
  RxString desc = ''.obs;
  RxString quantity = ''.obs;
  RxString price = ''.obs;
  final homeController = Get.find<HomeScreenController>();
  final Validation validation = Validation();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  late String updatedProductDateCreated;
  late int updatedProductId;
  RxBool hasPriceError = false.obs;
  RxBool hasQuantityError = false.obs;
  RxBool hasNameError = false.obs;
  RxString selectedMeasure = 'unit(s)'.obs;
  int? productKey;
  List<String> measurement = [
    'unit(s)',
    'keg(s)',
    'pack(s)',
    'crate(s)',
    'bottle(s)',
    'gallon(s)',
    'box(es)',
  ];
  RxString imagePath = ''.obs;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final source = await Get.bottomSheet<ImageSource>(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColors.secondary400,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text('Gallery'),
                  ],
                ),
                onTap: () => Get.back(result: ImageSource.gallery),
              ),
              GestureDetector(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.linked_camera_outlined,
                      color: AppColors.primary400,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text('Camera'),
                  ],
                ),
                onTap: () => Get.back(result: ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );

    if (source != null) {
      final imageFile = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (imageFile != null) {
        imagePath.value = imageFile.path;
      }
    }
  }

  void cancelImage() {
    imagePath.value = '';
  }

  void validatePrice() {
    hasPriceError.value = !validation.hasNumber(price.value)!;
  }

  void validateQuantity() {
    hasPriceError.value = !validation.hasNumber(price.value)!;
  }

  void createProduct(mode) {
    if (!mode) {
      homeController.addProduct(
        ProductModel(
          name: name.value,
          desc: desc.value,
          quantity: double.parse(quantity.value),
          price: double.parse(price.value),
          measure: selectedMeasure.value,
          image: imagePath.value,
          dateCreated: DateTime.now().toIso8601String(),
        ),
      );
    } else {
      homeController.updateProduct(
        ProductModel(
          id: updatedProductId,
          name: name.value,
          desc: desc.value,
          quantity: double.parse(quantity.value),
          price: double.parse(price.value),
          measure: selectedMeasure.value,
          image: imagePath.value,
          dateCreated: updatedProductDateCreated,
          dateModified: DateTime.now().toIso8601String(),
        ),
      );
    }

    resetField();
  }

  void resetField() {
    name.value = '';
    desc.value = '';
    price.value = '';
    quantity.value = '';
    descController.clear();
    quantityController.clear();
    priceController.clear();
    nameController.clear();
    imagePath.value = '';
    selectedMeasure.value = 'unit(s)';
  }

  void updateFields(ProductModel? product) {
    final quant = product!.quantity.toInt();
    price.value = product.price.toString();
    priceController.text = price.value;
    quantity.value = quant.toString();
    quantityController.text = quant.toString();
    name.value = product.name;
    nameController.text = name.value;
    selectedMeasure.value = product.measure;
    desc.value = product.desc ?? '';
    descController.text = desc.value;
    productKey = product.id;
    updatedProductDateCreated = product.dateCreated!;
    updatedProductId = product.id!;
    imagePath.value = product.image ?? '';
    update();
  }
}
