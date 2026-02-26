import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task/constant/app_colors.dart';
import 'package:task/gen/assets.gen.dart';
import '../../constant/app_assert_image.dart';
import '../../utils/app_size.dart';
import 'controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize AppSize with current screen size to avoid LateInitializationError
    Size size = MediaQuery.of(context).size;
    AppSize.size = size;

    return GetBuilder(
      init: SplashScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.instance.splashBg,
          body: Obx(
            () => Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
                child: AnimatedOpacity(
                  duration: Duration(seconds: 2),
                  opacity: controller.animation2.value,
                  child: AnimatedScale(scale: controller.animation.value, duration: Duration(seconds: 2), curve: Curves.easeOutExpo, child: SvgPicture.asset(Assets.logo.appLogo,height: 150,width: 270,)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
