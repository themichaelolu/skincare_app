import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/products/prod_controller.dart';
import 'package:skincare_app/src/core/domain/products/prod_db.dart';

import 'products.dart';

part 'add_product_controller.g.dart';

@riverpod
class AddProductController extends _$AddProductController {
  @override
  FutureOr<int?> build() async {
    return null;
  }

  Future<int?> addProduct({Product? product, Function? afterFetched}) async {
    final dbHelper = ref.read(productDatabaseHelperProvider);
    try {
      const AsyncValue.loading();
      final addProduct = await dbHelper.insertProduct(product);
      if (product == null) {
        return null;
      } else {
        AsyncValue.data(addProduct);
        debugPrint(addProduct.toString());
        ref.invalidate(loadProductsProvider);
        // debugPrint(productAdded.toString());
        afterFetched?.call();
      }
    } catch (e, s) {
      AsyncValue.error(e, s);
    }
    return null;
  }
}
