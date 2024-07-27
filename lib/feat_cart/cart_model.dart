class ProductModel {
  int? productId;
  String? name;
  double? price;
  String? imgUrl;
  int? quantity;
  int? storeId;
  bool selected = true;
  ProductModel({
    this.productId,
    this.name,
    this.price,
    this.imgUrl,
    this.quantity,
    this.storeId,
    required this.selected,
  });
}

class StoreModel {
  List<ProductModel>? products;
  String? name;
  String? imgUrl;
  double? totalPrice;
  double? totalQuantity;
  bool selected = true;
  StoreModel({
    this.products,
    this.name,
    this.imgUrl,
    this.totalPrice,
    this.totalQuantity,
    required this.selected,
  });
}

class CartModel {
  List<StoreModel>? stores;
  double? totalPrice;
  double? totalQuantity;
  String? payType;
  String? deliveryType;
  CartModel({
    this.stores,
    this.totalPrice,
    this.totalQuantity,
    this.payType,
  });
}
