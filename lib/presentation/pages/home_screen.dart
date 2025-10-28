import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:store_keeper_app/presentation/controllers/home_screen_controller.dart';
import 'package:store_keeper_app/presentation/pages/create_products_sheet.dart';
import 'package:store_keeper_app/presentation/widgets/app_snackbar.dart';
import 'package:store_keeper_app/presentation/widgets/app_switch_widget.dart';
import 'package:store_keeper_app/utils/constants/colors.dart';
import 'package:store_keeper_app/utils/constants/textstyles.dart';

import '../widgets/app_button_widget.dart';
import '../widgets/product_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.blackColor
          : AppColors.grey50,
      appBar: AppBar(
        title: Text('Store Keeper App', style: AppTextStyles.bodyMd),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: AppSwitch(
              value: controller.isDarkMode,
              onChanged: (val) {
                controller.toggleTheme();
              },
            ),
          ),
        ],
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.blackColor
            : AppColors.grey50,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness != Brightness.dark
              ? AppColors.primaryColor
              : AppColors.primary200,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () => Get.bottomSheet(
            CreateProductSheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          ),
          icon: Icon(
            Icons.add,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.blackColor
                : AppColors.grey50,
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : controller.productsList.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text('No Product Added'),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Get.bottomSheet(
                      CreateProductSheet(),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      'Click to Add Your First Product',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.info500,
                      ),
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...controller.productsList.map((item) {
                        return Slidable(
                          key: ValueKey(item.id),

                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  Get.bottomSheet(
                                    CreateProductSheet(product: item),
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Edit Product')),
                                  );
                                },
                                backgroundColor: AppColors.primary200,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  Get.dialog(
                                    _AppAlertDialog(
                                      content:
                                          'Do you really want to delete this product?',
                                      onAccept: () {
                                        controller.deleteProduct(item.id!);
                                        Get.back();
                                        appSnackBar(
                                          "Product Deleted",
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      },
                                    ),
                                  );
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),

                          child: ProductItemWidget(product: item),
                        );
                      }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _AppAlertDialog extends StatelessWidget {
  const _AppAlertDialog({required this.content, this.onAccept});
  final void Function()? onAccept;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.only(top: 29.0),
        child: Text(
          content,
          style: AppTextStyles.captionMd.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton.textButton(
              label: 'Cancel',
              labelTextStyle: AppTextStyles.bodyMd,
              onPressed: () => Get.back(),
            ),
            SizedBox(width: 40),
            AppButton(label: 'Yes', onPressed: onAccept, width: 100),
          ],
        ),
      ],
    );
  }
}
