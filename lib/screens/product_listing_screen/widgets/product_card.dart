import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:task/constant/app_colors.dart';
import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.instance.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.instance.dark200.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: CommonImage(
              src: product.image,
              height: 110,
              width: 110,
              fill: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: product.title,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.instance.dark500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColors.instance.start,
                        size: 16,
                      ),
                      const SizedBox(width: 3),
                      CommonText(
                        text: '${product.rating.rate}',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.instance.dark300,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(width: 4),
                      CommonText(
                        text: '(${product.rating.count})',
                        fontSize: 11,
                        textColor: AppColors.instance.dark200,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CommonText(
                    text: '\$${product.price.toStringAsFixed(2)}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.instance.primary500,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
