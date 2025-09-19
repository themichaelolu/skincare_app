import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/products/prod_controller.dart';
import 'package:skincare_app/src/core/domain/products/prod_db.dart';

part 'delete_product_controller.g.dart';

@riverpod
class DeleteProductController extends _$DeleteProductController {
  @override
  FutureOr<int?> build() async {
    return null;
  }

  Future<int?> deleteProduct({
    int? id,
    Function? afterFetched,
  }) async {
    final dbHelper = ref.read(productDatabaseHelperProvider);
    try {
      const AsyncValue.loading();
      final deleteProduct = await dbHelper.deleteProduct(id ?? -1);
      if (id == null) {
        return null;
      } else {
        AsyncValue.data(deleteProduct);
        ref.invalidate(loadProductsProvider);
        afterFetched?.call();
      }
    } catch (e, s) {
      AsyncValue.error(e, s);
    }
    return null;
  }
}
