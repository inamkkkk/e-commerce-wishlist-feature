import 'package:ecommerce_wishlist/services/wishlist_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistService = Provider.of<WishlistService>(context);
    final wishlistItems = wishlistService.wishlistItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: wishlistItems.isEmpty
          ? const Center(
              child: Text('Your wishlist is empty.'),
            )
          : ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final product = wishlistItems[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('$${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      wishlistService.removeFromWishlist(product.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}