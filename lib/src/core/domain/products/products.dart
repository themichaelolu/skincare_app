import 'dart:convert';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  Map<String, dynamic> toJson() {
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

  factory Product.fromJson(Map<String, dynamic> map) {
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

