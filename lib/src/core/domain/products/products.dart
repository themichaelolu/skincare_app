import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';

class Product {
  final int? id;
  final String? productName;
  final String? productBrand;
  final double? price;
  final String? description;
  final String? image;
  final String? howToUse;
  final List<String>? ingredients;
  final int? reviewCount;
  final List<String>? sizes;
  final String? productType;

  Product({
    this.id,
    this.productName,
    this.productBrand,
    this.price,
    this.description,
    this.image,
    this.howToUse,
    this.ingredients,
    this.reviewCount,
    this.productType,
    this.sizes = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'productBrand': productBrand,
      'price': price,
      'description': description,
      'image': image,
      'howToUse': howToUse,
      'ingredients': ingredients?.join(','),
      'reviewCount': reviewCount,
      'productType': productType,
      'sizes': sizes?.join(','),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      productName: map['productName'],
      productBrand: map['productBrand'],
      price: map['price'],
      description: map['description'],
      image: map['image'],
      howToUse: map['howToUse'],
      ingredients: map['ingredients']?.split(','),
      reviewCount: map['reviewCount'],
      productType: map['productType'],
      sizes: map['sizes']?.split(','),
    );
  }

  static List<Product> products = [
    Product(
      productBrand: 'Haruharu Wonder',
      productName: 'Black Rice Hyaluronic Toner',
      reviewCount: 1000,
      productType: 'Toner',
      price: 14000,
      description:
          "100% Centella asiatica extract from the untouched nature of Madagascar. SKIN1004's signature ampoule with a light watery texture and non-sticky formula. Madagascan Centella asiatica contains 7 times more soothing actives than other centella asiatica. Only consists the single most effective ingredient and nothing else to ensure maximized benefits. Immediately calms and hydrates sensitive skin.",
      howToUse: 'Just use it',
      image: AppAssets.bigPic,
      ingredients: [
        'Ingredients',
        'Milk',
        'Cream',
      ],
      sizes: [
        '50 ml',
        '100 ml',
        '200 ml',
      ],
    )
  ];
}

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);

  void fetchProduct() {
    final products = [
      Product(
        productBrand: 'Haruharu Wonder',
        productName: 'Black Rice Hyaluronic Toner',
        reviewCount: 1000,
        productType: 'Toner',
        price: 14000,
        description:
            "100% Centella asiatica extract from the untouched nature of Madagascar. SKIN1004's signature ampoule with a light watery texture and non-sticky formula. Madagascan Centella asiatica contains 7 times more soothing actives than other centella asiatica. Only consists the single most effective ingredient and nothing else to ensure maximized benefits. Immediately calms and hydrates sensitive skin.",
        howToUse: 'Just use it',
        image: AppAssets.bigPic,
        ingredients: [
          'Ingredients',
          'Milk',
          'Cream',
        ],
        sizes: [
          '50',
          '100',
          '200',
        ],
      ),
      Product(
          productBrand: 'Nivea',
          productName: 'Moisturiser',
          reviewCount: 2000,
          productType: 'Cleanser',
          price: 15000,
          description:
              "100% Centella asiatica extract from the untouched nature of Madagascar. SKIN1004's signature ampoule with a light watery texture and non-sticky formula. Madagascan Centella asiatica contains 7 times more soothing actives than other centella asiatica. Only consists the single most effective ingredient and nothing else to ensure maximized benefits. Immediately calms and hydrates sensitive skin.",
          howToUse: 'Just use it',
          image: AppAssets.bigPic,
          ingredients: [
            'Ingredients'
          ],
          sizes: [
            '100',
            '150',
            '200',
          ])
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
