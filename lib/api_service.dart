import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<dynamic>> fetchProducts({int offset = 0, int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/products?offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<dynamic>> fetchProductsByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl/categories/$categoryId/products'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products for category $categoryId');
    }
  }
}
