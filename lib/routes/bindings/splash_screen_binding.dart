import 'package:get/get.dart';
import '../../screens/splash_screen/controller/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SplashScreenController());

  }
}
