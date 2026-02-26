import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_kit/utils/app_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/connectivity_service/connectivity_service.dart';

// Simplified middleware: when there's no internet we show a SnackBar and
// block navigation to the requested route (return null = allow the original
// route to continue so the app never crashes into a deleted screen).
bool _isNavigating = false;

class InternetCheckMiddleWare extends GetMiddleware {
  ConnectivityService connectivityService =
      Get.isRegistered<ConnectivityService>()
      ? Get.find<ConnectivityService>()
      : Get.put<ConnectivityService>(ConnectivityService());

  List<ConnectivityResult> result = <ConnectivityResult>[];

  InternetCheckMiddleWare() {
    _onInitialData();
  }

  _onInitialData() {
    try {
      connectivityService.connectivity.onConnectivityChanged.listen((
        data,
      ) async {
        result = <ConnectivityResult>[];
        result.addAll(data);
        if (data.contains(ConnectivityResult.none) && !_isNavigating) {
          _isNavigating = true;
          Get.snackbar(
            'No Internet',
            'Please check your connection.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
          _isNavigating = false;
        }
      });
    } catch (e) {
      AppLogger.error('InternetCheckMiddleWare error: $e');
    }
  }

  @override
  RouteSettings? redirect(String? route) {
    // Allow all routes — connectivity issues are shown via SnackBar.
    return null;
  }

  @override
  Widget onPageBuilt(Widget page) {
    return super.onPageBuilt(page);
  }
}
