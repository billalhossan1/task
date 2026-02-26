import 'package:get/get.dart';
import 'package:task/screens/product_listing_screen/controller/product_listing_controller.dart';

class ProductListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListingController>(() => ProductListingController());
  }
}
