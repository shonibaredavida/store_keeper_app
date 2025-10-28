import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../repositories/db.dart';

class HomeScreenController extends GetxController {
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  RxBool isDarkMode = false.obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  RxBool isLoading = false.obs;

  Future<void> loadProducts() async {
    final data = await _dbHelper.getAllProducts();
    productsList.assignAll(data);
    isLoading.value = false;
  }

  // Add product
  Future<void> addProduct(ProductModel product) async {
    isLoading.value = true;
    await _dbHelper.insertProduct(product);
    await loadProducts();
    isLoading.value = false;
  }

  // Update product
  Future<void> updateProduct(ProductModel product) async {
    await _dbHelper.updateProduct(product);
    await loadProducts();
  }

  // Delete product
  Future<void> deleteProduct(int id) async {
    await _dbHelper.deleteProduct(id);
    int index = productsList.indexWhere((p) => p.id == id);
    productsList.removeAt(index);
    await loadProducts();
  }

  @override
  void onInit() {
    isLoading.value = true;
    loadProducts();
    if (Get.isDarkMode) {
      isDarkMode.value = true;
    } else {
      isDarkMode.value = false;
    }

    super.onInit();
  }

  void toggleTheme() {
    Get.changeTheme(
      isDarkMode.value
          ? Get.theme == ThemeData.dark()
                ? ThemeData.light()
                : ThemeData.dark()
          : Get.theme == ThemeData.light()
          ? ThemeData.dark()
          : ThemeData.light(),
    );
  }
}
