import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_app/src/core/domain/products/prod_db_helper.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';

import 'prod_controller.dart';

final productProvider = StateNotifierProvider<ProductNotifier, List<Product>>(
  (ref) {
    return ProductNotifier()..fetchProduct();
  },
);


final databaseProvider = Provider<ProductDatabaseHelper>((ref) {
  return ProductDatabaseHelper();
});



final productControllerProvider = StateNotifierProvider<ProductController, ProductState>((ref) {
  final dbHelper = ref.watch(databaseProvider);
  return ProductController(dbHelper);
});




