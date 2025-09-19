
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:skincare_app/src/core/domain/cloud_firestore/cloud_firestore.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/features/home/product_detail.dart';


final _firestore = FirebaseFirestore.instance;

class LikedProductsView extends StatefulWidget {
  const LikedProductsView({super.key});

  @override
  State<LikedProductsView> createState() => _LikedProductsViewState();
}

class _LikedProductsViewState extends State<LikedProductsView> {
  CloudFirestoreService? service;

  @override
  void initState() {
    service = CloudFirestoreService(
      db: FirebaseFirestore.instance
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _firestore.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.darkGreen,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('Check your connection'),
            );
          } else if (snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
            return const Center(
              child: Text('No products available'),
            );
          }

          final docs = snapshot.data?.docs;
          return GridView.builder(
            itemCount: docs!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.77,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final product = docs[index];
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ProductDetailView(),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product['productImage'] != null)
                      Image.network(
                        product['productImage'],
                        height: 160,
                        width: 155,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 50,
                          );
                        },
                      )
                    else
                      const Icon(
                        Icons.image_not_supported,
                        size: 200,
                      ),
                    8.h.verticalSpace,
                    Text(
                      product['productBrand'] ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.darkGreen,
                          ),
                    ),
                    4.h.verticalSpace,
                    Text(
                      product['productName'] ?? '',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      NumberFormat.decimalPattern().format(product['price']),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                ),
              );
            },
          );
        },
      
      ),
    );
  }
}
