import 'package:skincare_app/src/core/domain/products/products.dart';

class Cart {
  final List<Product> products;

  Cart({this.products = const <Product>[]});

  void addProduct(Product product) {
    products.add(product);
  }

  void removeProduct(Product product) {
    products.remove(product);
  }

  Map<Product, int> productQuantity() {
    final quantity = <Product, int>{};

   for (var product in products) {
  if (!quantity.containsKey(product)) {
    quantity[product] = 1;
  } else {
    quantity[product] = quantity[product]! + 1;
  }
}

    return quantity;
  }

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price!.toDouble());

  double deliveryFee(subtotal) {
    if (subtotal >= 30.0) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  String get subtotalString => subtotal.toStringAsFixed(2);
}
