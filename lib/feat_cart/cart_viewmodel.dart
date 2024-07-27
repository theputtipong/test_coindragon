import 'package:flutter/material.dart';
import 'cart_model.dart';

class CartViewModel with ChangeNotifier {
  List<StoreModel> stores = [];

  double? totalPrice;

  double? totalQuantity;

  addStoreToCart(StoreModel store) {
    stores.add(store);
    notifyListeners();
  }

  removeStoreFromCart(StoreModel store) {
    stores.remove(store);
    notifyListeners();
  }

  selectedStore(StoreModel store) {
    store.selected = !store.selected;
    notifyListeners();
  }

  clearCart() {
    stores = [];
    totalPrice = 0;
    totalQuantity = 0;
    notifyListeners();
  }

  calculateTotalFromSelectedStore() {
    totalPrice = 0;
    totalQuantity = 0;
    for (var element in stores) {
      if (element.selected == true) {
        totalPrice = (totalPrice ?? 0) + (element.totalPrice ?? 0);
        totalQuantity = (totalQuantity ?? 0) + (element.totalQuantity ?? 0);
      }
    }
    notifyListeners();
  }

  addProductToCart(StoreModel store, int productId) {
    for (ProductModel element in store.products?.toList() ?? []) {
      if (element.productId == productId) {
        element.quantity = element.quantity! + 1;
        store.totalPrice = element.price! * element.quantity!;
        store.totalQuantity = element.quantity! + 1;
        break;
      }
    }
    calculateTotalFromSelectedStore();
  }

  removeProductFromCart(StoreModel store, int productId) {
    for (ProductModel element in store.products?.toList() ?? []) {
      if (element.productId == productId) {
        element.quantity = element.quantity! - 1;
        store.totalPrice = element.price! * element.quantity!;
        store.totalQuantity = element.quantity! - 1;
        break;
      }
    }
    calculateTotalFromSelectedStore();
  }

  selectedProduct(StoreModel store, int productId) {
    for (ProductModel element in store.products?.toList() ?? []) {
      if (element.productId == productId) {
        element.selected = !element.selected;
        break;
      }
    }
    calculateTotalFromSelectedStore();
  }
}
