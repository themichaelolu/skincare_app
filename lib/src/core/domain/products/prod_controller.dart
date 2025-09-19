import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/products/prod_db.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';

part 'prod_controller.g.dart';

@riverpod
Future<List<Product>?>? loadProducts(LoadProductsRef ref) async {
  final dbHelper = ref.read(productDatabaseHelperProvider);
  try {
    const AsyncLoading();
    final products = await dbHelper.getProducts();
    debugPrint(products.toString());
    if (products != null) {
      debugPrint('prod:${products.toString()}');
      AsyncData(products);
      return products;
    } else {
     return products;
    }
  } catch (e, s) {
    AsyncError(e, s);
  }
  return null;
}
