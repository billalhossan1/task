import 'package:get/get.dart';
import 'package:task/screens/product_listing_screen/model/user_model.dart';
import 'package:task/screens/product_listing_screen/service/fakestore_service.dart';
import 'package:task/utils/error_log.dart';
import '../model/product_model.dart';

// Tab 0 = All products (20 items — enough to scroll and test collapse)
// Tab 1 = Electronics (6 items)
// Tab 2 = Clothing (men's + women's, 10 items)
const List<String> kTabLabels = ['All', 'Electronics', 'Clothing'];

class ProductListingController extends GetxController {
  final RxInt currentTabIndex = 0.obs;

  final Map<int, List<ProductModel>> _tabProducts = {0: [], 1: [], 2: []};
  final Map<int, bool> _tabLoading = {0: false, 1: false, 2: false};
  final Map<int, bool> _tabLoadDone = {0: false, 1: false, 2: false};

  UserModel? userProfile;
  bool isProfileLoading = false;

  List<ProductModel> get products => _tabProducts[currentTabIndex.value] ?? [];
  bool get isLoading => _tabLoading[currentTabIndex.value] ?? false;
  bool get isLoadDone => _tabLoadDone[currentTabIndex.value] ?? false;

  @override
  void onInit() {
    super.onInit();
    loadProducts(0);
    loadUserProfile();
  }

  Future<void> loadProducts(int tabIndex) async {
    try {
      if (_tabLoading[tabIndex] == true) return;
      _tabLoading[tabIndex] = true;
      update();

      List<ProductModel> list;
      if (tabIndex == 0) {
        list = await FakestoreService.getAllProducts();
      } else if (tabIndex == 1) {
        list = await FakestoreService.getProductsByCategory('electronics');
      } else {
        final mens = await FakestoreService.getProductsByCategory(
          "men's clothing",
        );
        final womens = await FakestoreService.getProductsByCategory(
          "women's clothing",
        );
        list = [...mens, ...womens];
      }

      _tabProducts[tabIndex] = list;
      _tabLoadDone[tabIndex] = true;
    } catch (e) {
      errorLog('loadProducts', e);
    } finally {
      _tabLoading[tabIndex] = false;
      update();
    }
  }

  Future<void> refreshTab() async {
    try {
      final idx = currentTabIndex.value;
      _tabLoadDone[idx] = false;
      _tabProducts[idx] = [];
      update();
      await loadProducts(idx);
    } catch (e) {
      errorLog('refreshTab', e);
    }
  }

  Future<void> loadUserProfile() async {
    try {
      isProfileLoading = true;
      update();
      userProfile = await FakestoreService.getUserProfile(1);
    } catch (e) {
      errorLog('loadUserProfile', e);
    } finally {
      isProfileLoading = false;
      update();
    }
  }

  void switchTab(int index) {
    if (index < 0 || index >= kTabLabels.length) return;
    if (currentTabIndex.value == index) return;
    currentTabIndex.value = index;
    update();
    if (_tabProducts[index]!.isEmpty && _tabLoading[index] == false) {
      loadProducts(index);
    }
  }
}
