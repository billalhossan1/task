import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/error_log.dart';

class SplashScreenController extends GetxController {
  RxDouble animation = 0.0.obs;
  RxDouble animation2 = 0.0.obs;

  Future<void> onInitialDataLoadScreen() async {
    try {
      Future.delayed(Durations.medium1, () {
        animation.value = 1.0;
        animation2.value = 1.0;
      });

      // Navigate directly to the main app — no login required.
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(AppRoutes.instance.appNavigationScreen);
      });
    } catch (e) {
      errorLog('onInitialDataLoadScreen', e);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(AppRoutes.instance.appNavigationScreen);
      });
    }
  }

  @override
  void onInit() {
    onInitialDataLoadScreen();
    super.onInit();
  }
}
