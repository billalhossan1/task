import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constant/app_colors.dart';
import 'package:task/routes/app_routes.dart';
import 'controller/product_listing_controller.dart';
import 'widgets/product_card.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  late final ProductListingController _ctrl;

  double _swipeStartX = 0;
  double _swipeStartY = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.find<ProductListingController>();
  }

  void _onPanStart(DragStartDetails d) {
    _swipeStartX = d.globalPosition.dx;
    _swipeStartY = d.globalPosition.dy;
  }

  void _onPanEnd(DragEndDetails d) {
    final dx = d.globalPosition.dx - _swipeStartX;
    final dy = d.globalPosition.dy - _swipeStartY;
    if (dx.abs() > dy.abs() && dx.abs() > 40) {
      if (dx < 0) {
        _ctrl.switchTab((_ctrl.currentTabIndex.value + 1).clamp(0, 2));
      } else {
        _ctrl.switchTab((_ctrl.currentTabIndex.value - 1).clamp(0, 2));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanEnd: _onPanEnd,
      child: GetBuilder<ProductListingController>(
        builder: (ctrl) {
          return SafeArea(
            child: SmartListLoader(
              appbar: _buildHeader(ctrl),

              onColapsAppbar: _buildTabBar(ctrl),
              itemCount: ctrl.products.length,
              itemBuilder: (_, i) => ProductCard(product: ctrl.products[i]),
              isLoading: ctrl.isLoading,
              isLoadDone: ctrl.isLoadDone,
              onRefresh: ctrl.refreshTab,
              padding: const EdgeInsets.only(bottom: 24),
            ),
          );
        },
      ),
    );
  }

  // ── Collapsible banner ────────────────────────────────────────────────────
  Widget _buildHeader(ProductListingController ctrl) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Brand row + search bar (collapses on scroll)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.instance.primary,
                AppColors.instance.primary500,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Brand row
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: 'Task',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.instance.white,
                              textAlign: TextAlign.left,
                            ),
                            CommonText(
                              text: 'Find what you love',
                              fontSize: 12,
                              textColor: AppColors.instance.white.withOpacity(
                                0.75,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Get.toNamed(AppRoutes.instance.userProfileScreen),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.transparent,
                            child: ctrl.isProfileLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    Icons.person_rounded,
                                    color: AppColors.instance.white,
                                    size: 24,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildTabBar(ctrl),
      ],
    );
  }

  Widget _buildTabBar(ProductListingController ctrl) {
    return Container(
      color: AppColors.instance.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(kTabLabels.length, (i) {
              final selected = ctrl.currentTabIndex.value == i;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => ctrl.switchTab(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selected
                              ? AppColors.instance.primary500
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonText(
                          text: kTabLabels[i],
                          fontSize: 13,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          textColor: selected
                              ? AppColors.instance.primary500
                              : AppColors.instance.dark300,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          Container(height: 1, color: AppColors.instance.border),
        ],
      ),
    );
  }
}
