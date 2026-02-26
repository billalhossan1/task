import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constant/app_colors.dart';
import 'package:task/screens/product_listing_screen/controller/product_listing_controller.dart';
import 'package:task/screens/product_listing_screen/product_listing_screen.dart';
import 'package:task/screens/user_profile_screen/user_profile_screen.dart';
import 'controller/app_navigation_screen_controller.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AppNavigationScreenController(),
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              GetBuilder<ProductListingController>(
                init: ProductListingController(),
                builder: (_) => const ProductListingScreen(),
              ),
              const UserProfileScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: controller.changeIndex,
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: AppColors.instance.primary500,
            unselectedItemColor: AppColors.instance.dark300,
            backgroundColor: AppColors.instance.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.store_outlined),
                activeIcon: Icon(Icons.store),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
