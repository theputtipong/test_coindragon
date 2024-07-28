import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_coindragon/approute.dart';
import 'package:test_coindragon/feat_cart/cart_viewmodel.dart';

import '../main.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: cartProvider.stores.isEmpty
          ? GestureDetector(
              onTap: () => navigatorKey.currentState?.pushNamed(Approute.content),
              child: const Center(child: Text('Your cart is empty.')))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.stores.length,
                    itemBuilder: (context, index) {
                      final store = cartProvider.stores[index];
                      return ExpansionTile(
                        title: Text(store.name ?? 'Store'),
                        leading: store.imgUrl != null ? Image.network(store.imgUrl!) : const Icon(Icons.store),
                        children: store.products!.map((product) {
                          return ListTile(
                            leading: product.imgUrl != null
                                ? Image.network(product.imgUrl!)
                                : const Icon(Icons.shopping_cart),
                            title: Text(product.name ?? 'Product'),
                            subtitle: Text(
                                'Quantity: ${product.quantity}, Price: \$${(product.price ?? 0) * (product.quantity ?? 0)}'),
                            trailing: Text('Total: \$${(product.price ?? 0) * (product.quantity ?? 0)}'),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total Price: \$${cartProvider.totalPrice?.toStringAsFixed(2) ?? '0.00'}\nTotal Quantity: ${cartProvider.totalQuantity?.toStringAsFixed(0) ?? '0'}',
                  ),
                ),
              ],
            ),
    );
  }
}
