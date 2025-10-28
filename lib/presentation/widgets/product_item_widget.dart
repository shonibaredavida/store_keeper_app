import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_keeper_app/helper_functions.dart';
import 'package:store_keeper_app/models/product_model.dart';
import 'package:store_keeper_app/utils/constants/colors.dart';
import 'package:store_keeper_app/utils/constants/textstyles.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.grey500
              : AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.whiteColor
                              : AppColors.grey100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 70,
                        width: 70,
                        child: product.image!.length < 2
                            ? Center(
                                child: Icon(
                                  Icons.shopping_bag,
                                  color: AppColors.primaryColor,
                                  size: 40,
                                ),
                              )
                            : Image.file(
                                File(product.image!),
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            capitalizeFirst(product.name),
                            style: AppTextStyles.labelLg,
                          ),
                          SizedBox(height: 3),

                          Text(formatCompactCurrency(product.price)),
                          SizedBox(height: 3),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.dateModified == null
                                    ? 'Created: '
                                    : 'Updated: ',
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.grey200,
                                ),
                              ),
                              Text(
                                AppCustomDateTime(
                                  DateTime.parse(
                                    product.dateModified ??
                                        product.dateCreated!,
                                  ),
                                ).toString(),
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.grey200,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                  text: appCompactQuantity(product.quantity),
                  style: AppTextStyles.header.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: product.measure,
                      style: AppTextStyles.captionSm,
                    ),
                  ],
                ),
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
