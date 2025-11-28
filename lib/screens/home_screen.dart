import 'package:ecommerce_wishlist/models/product.dart';
import 'package:ecommerce_wishlist/screens/wishlist_screen.dart';
import 'package:ecommerce_wishlist/services/wishlist_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistService = Provider.of<WishlistService>(context);
    final products = [
      Product(id: '1', name: 'Product 1', price: 20.0),
      Product(id: '2', name: 'Product 2', price: 30.0),
      Product(id: '3', name: 'Product 3', price: 40.0),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WishlistScreen()),
          );
        }, icon: const Icon(Icons.favorite))],),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('$${product.price}'),
            trailing: IconButton(
              icon: Icon(
                wishlistService.isProductInWishlist(product.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                if (wishlistService.isProductInWishlist(product.id)) {
                  wishlistService.removeFromWishlist(product.id);
                } else {
                  wishlistService.addToWishlist(product);
                }
              },
            ),
          );
        },
      ),
    );
  }
}