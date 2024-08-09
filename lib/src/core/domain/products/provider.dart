import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';

final productProvider = StateNotifierProvider<ProductNotifier, List<Product>>(
  (ref) {
    return ProductNotifier()..fetchProduct();
  },
);





