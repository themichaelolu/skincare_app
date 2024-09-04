import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_app/src/core/domain/products/prod_db_helper.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';


// Define the ProductState class
class ProductState {
  final List<Product> products;
  final bool isLoading;
  final String? error;

  ProductState({
    required this.products,
    this.isLoading = false,
    this.error,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}


class ProductController extends StateNotifier<ProductState> {
  final ProductDatabaseHelper dbHelper;

  ProductController(this.dbHelper) : super(ProductState(products: [])) {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      state = state.copyWith(isLoading: true);
      final products = await dbHelper.getProducts();
      state = state.copyWith(products: products, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> addProduct(Product product) async {
    await dbHelper.insertProduct(product);
    _loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    await dbHelper.updateProduct(product);
    _loadProducts();
  }

  Future<void> deleteProduct(int id) async {
    await dbHelper.deleteProduct(id);
    _loadProducts();
  }
}
