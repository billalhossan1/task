import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';
import '../model/user_model.dart';

class FakestoreService {
  static const String _base = 'https://fakestoreapi.com';

  static Future<String?> login(String username, String password) async {
    final res = await http.post(
      Uri.parse('$_base/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return data['token'] as String?;
    }
    return null;
  }

  static Future<List<ProductModel>> getProductsByCategory(
    String category,
  ) async {
    final res = await http.get(Uri.parse('$_base/products/category/$category'));
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List<dynamic>;
      return list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  static Future<List<ProductModel>> getAllProducts() async {
    final res = await http.get(Uri.parse('$_base/products'));
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List<dynamic>;
      return list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  static Future<UserModel?> getUserProfile(int userId) async {
    final res = await http.get(Uri.parse('$_base/users/$userId'));
    if (res.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    }
    return null;
  }
}
