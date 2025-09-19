import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/products/prod_db_helper.dart';


part 'prod_db.g.dart';

@riverpod
ProductDatabaseHelper productDatabaseHelper(ProductDatabaseHelperRef ref) =>
    ProductDatabaseHelper();
