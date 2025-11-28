import 'dart:convert';

import 'package:ecommerce_wishlist/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistService extends ChangeNotifier {
  List<Product> _wishlistItems = [];

  List<Product> get wishlistItems => _wishlistItems;

  WishlistService() {
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistString = prefs.getString('wishlist');
    if (wishlistString != null) {
      final wishlistJson = jsonDecode(wishlistString) as List;
      _wishlistItems = wishlistJson.map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistJson = _wishlistItems.map((item) => item.toJson()).toList();
    final wishlistString = jsonEncode(wishlistJson);
    await prefs.setString('wishlist', wishlistString);
  }

  void addToWishlist(Product product) {
    _wishlistItems.add(product);
    _saveWishlist();
    notifyListeners();
  }

  void removeFromWishlist(String productId) {
    _wishlistItems.removeWhere((product) => product.id == productId);
    _saveWishlist();
    notifyListeners();
  }

  bool isProductInWishlist(String productId) {
    return _wishlistItems.any((product) => product.id == productId);
  }
}