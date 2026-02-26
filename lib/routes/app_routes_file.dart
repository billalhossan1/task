import 'package:get/get.dart';
import 'package:task/screens/product_listing_screen/product_listing_screen.dart';
import 'package:task/screens/user_profile_screen/user_profile_screen.dart';
import '../screens/app_navigation_screen/app_navigation_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import 'app_routes.dart';
import 'bindings/navigation_screen_binding.dart';
import 'bindings/product_listing_binding.dart';
import 'bindings/splash_screen_binding.dart';
import 'internet_check_middle_ware.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  // Splash
  GetPage(
    name: AppRoutes.instance.initial,
    binding: SplashScreenBinding(),
    page: () => const SplashScreen(),
  ),

  // Main app – bottom-nav host
  GetPage(
    name: AppRoutes.instance.appNavigationScreen,
    binding: NavigationScreenBinding(),
    page: () => const AppNavigationScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),

  // Product listing (standalone, kept for deep-link convenience)
  GetPage(
    name: AppRoutes.instance.productListingScreen,
    binding: ProductListingBinding(),
    page: () => const ProductListingScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),

  // User profile (standalone push)
  GetPage(
    name: AppRoutes.instance.userProfileScreen,
    binding: NavigationScreenBinding(),
    page: () => const UserProfileScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
];
