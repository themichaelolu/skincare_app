import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/products/prod_controller.dart';
import 'package:skincare_app/src/core/domain/products/prod_db.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';

part 'update_product_ref.g.dart';

@riverpod
class UpdateProduct extends _$UpdateProduct {
  @override
  FutureOr<int?> build() async {
    return null;
  }

  Future<int?> updateProduct({Product? product, Function? afterFetched}) async {
    final dbHelper = ref.read(productDatabaseHelperProvider);
    try {
      const AsyncValue.loading();
      final updateProduct = await dbHelper.updateProduct(product);
      if (product == null) {
        return null;
      } else {
        AsyncValue.data(updateProduct);
        ref.invalidate(loadProductsProvider);
         afterFetched?.call();
      }

     
    } catch (e, s) {
      AsyncValue.error(e, s);
    }
    return null;
  }
}
