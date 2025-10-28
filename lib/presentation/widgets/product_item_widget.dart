import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_keeper_app/helper_functions.dart';
import 'package:store_keeper_app/models/product_model.dart';
import 'package:store_keeper_app/utils/constants/colors.dart';
import 'package:store_keeper_app/utils/constants/textstyles.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_NG',
      symbol: 'N',
    );
    final productPrice = currencyFormatter.format(product.price);
    return Card(
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
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 80,
                    width: 80,
                    child: product.image!.length < 2
                        ? Center(child: FlutterLogo(size: 70))
                        : Image.file(File(product.image!), fit: BoxFit.cover),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(product.name, style: AppTextStyles.labelLg),
                      SizedBox(height: 3),

                      Text(productPrice),
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
                            formatCustomDateTime(
                              DateTime.parse(
                                product.dateModified ?? product.dateCreated!,
                              ),
                            ).toString(),
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
            Text.rich(
              TextSpan(
                text: NumberFormat('#,##0').format(product.quantity),
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
            ),
          ],
        ),
      ),
    );
  }
}
