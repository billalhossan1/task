import 'package:get/get.dart';
import 'package:task/screens/product_listing_screen/model/user_model.dart';
import 'package:task/screens/product_listing_screen/service/fakestore_service.dart';
import 'package:task/utils/error_log.dart';

class UserProfileController extends GetxController {
  UserModel? user;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading = true;
      update();
      user = await FakestoreService.getUserProfile(1);
    } catch (e) {
      errorLog('loadProfile', e);
    } finally {
      isLoading = false;
      update();
    }
  }
}
