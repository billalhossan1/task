import 'package:get/get.dart';
import '../../screens/app_navigation_screen/controller/app_navigation_screen_controller.dart';
import '../../screens/user_profile_screen/controller/user_profile_controller.dart';

class NavigationScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => AppNavigationScreenController());
    Get.lazyPut(() => UserProfileController());
  }
}
