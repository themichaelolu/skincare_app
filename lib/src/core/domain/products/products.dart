import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';

class Product {
  final String? productName;
  final String? productBrand;
  final double? price;
  final String? description;
  final List<ProductImages> images;
  final String? howToUse;
  final String? ingredients;
  final int? reviewCount;
  final List<String>?sizes;

  Product({
    this.productName,
    this.productBrand,
    this.price,
    this.description,
    this.images = const [],
    this.howToUse,
    this.ingredients,
    this.reviewCount,
    this.sizes = const [],
  });

  static List<Product> products = [
    Product(
      productBrand: 'Haruharu Wonder',
      productName: 'Black Rice Hyaluronic Toner',
      reviewCount: 1000,
      price: 14000,
      description:
          "100% Centella asiatica extract from the untouched nature of Madagascar. SKIN1004's signature ampoule with a light watery texture and non-sticky formula. Madagascan Centella asiatica contains 7 times more soothing actives than other centella asiatica. Only consists the single most effective ingredient and nothing else to ensure maximized benefits. Immediately calms and hydrates sensitive skin.",
      howToUse: 'Just use it',
      images: [
        ProductImages(
          smallPicture: AppAssets.product,
          bigPicture: AppAssets.bigPic,
        ),
      ],
      ingredients: 'Ingredients',
      sizes: [
        '50 ml',
        '100 ml',
        '200 ml',
      ],
    )
  ];
}

class ProductImages {
  final String? smallPicture;
  final String? bigPicture;

  ProductImages({this.smallPicture, this.bigPicture});
}

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);

  void fetchProduct() {
    final products = [
      Product(
        productBrand: 'Haruharu Wonder',
        productName: 'Black Rice Hyaluronic Toner',
        reviewCount: 1000,
        price: 14000,
        description:
            "100% Centella asiatica extract from the untouched nature of Madagascar. SKIN1004's signature ampoule with a light watery texture and non-sticky formula. Madagascan Centella asiatica contains 7 times more soothing actives than other centella asiatica. Only consists the single most effective ingredient and nothing else to ensure maximized benefits. Immediately calms and hydrates sensitive skin.",
        howToUse: 'Just use it',
        images: [
          ProductImages(
            smallPicture: AppAssets.product,
            bigPicture: AppAssets.bigPic,
          ),
        ],
        ingredients: 'Ingredients',
        sizes: [
        '50 ml',
        '100 ml',
        '200 ml',
      ],
      ),
      Product(
        productBrand: 'Nivea',
        productName: 'Moisturiser',
        reviewCount: 2000,
        price: 15000,
        description:
            "100% Centella asiatica extract from the untouched nature of Madagascar. SKIN1004's signature ampoule with a light watery texture and non-sticky formula. Madagascan Centella asiatica contains 7 times more soothing actives than other centella asiatica. Only consists the single most effective ingredient and nothing else to ensure maximized benefits. Immediately calms and hydrates sensitive skin.",
        howToUse: 'Just use it',
        images: [
          ProductImages(
            smallPicture: AppAssets.product,
            bigPicture: AppAssets.bigPic,
          ),
        ],
        ingredients: 'Ingredients',
      )
    ];
    state = products;
  }

  void addProduct(Product product) {
    state = [...state, product];
  }

  void removeProduct(String productName) {
    state =
        state.where((product) => product.productName != productName).toList();
  }

  // void updateProduct(Product updatedProduct) {
  //   state = state.map((product) {
  //     return product.productName == updatedProduct.productName
  //         ? updatedProduct
  //         : product;
  //   }).toList();
  // }
}
