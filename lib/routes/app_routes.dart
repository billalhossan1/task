class AppRoutes {
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  static AppRoutes get instance => _instance;

  // Initial / Splash
  final String initial = '/';

  // Main app
  final String appNavigationScreen = '/app-navigation-screen';
  final String productListingScreen = '/product-listing-screen';
  final String userProfileScreen = '/user-profile-screen';
}
