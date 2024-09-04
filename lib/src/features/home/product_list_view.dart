import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare_app/src/core/domain/products/provider.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import '../../themes/tripple_rail.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Product List'),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final productState = ref.watch(productControllerProvider);

          if (productState.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (productState.error != null) {
            return Center(child: Text('Error: ${productState.error}'));
          } else if (productState.products.isEmpty) {
            return const Center(child: Text('No products.'));
          }

          final products = productState.products;

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: TrippleRail(
                    trailExpanded: true,
                    leading: Row(
                      children: [
                        if (product.image != null && product.image!.isNotEmpty)
                          Image.file(
                            File(product.image!),
                            height: 50,
                            width: 50,
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
                            size: 50,
                          ),
                      ],
                    ),
                    middle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.productName ?? 'Unknown Product'),
                        10.h.verticalSpace,
                        Text(product.productBrand ?? 'Unknown Brand'),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 50,
                      child: IconButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.lightGreen,
                                  title: Text(
                                    'Delete',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  content: Text(
                                    'Are you sure you want to delete this product?',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          final productController = ref.read(
                                              productControllerProvider
                                                  .notifier);
                                          await productController
                                              .deleteProduct(product.id!);

                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Yes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color:
                                                      AppColors.primaryColor),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'No',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color:
                                                      AppColors.primaryColor),
                                        ))
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          CupertinoIcons.delete,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
