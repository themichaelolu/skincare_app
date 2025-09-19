import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare_app/src/core/domain/products/delete_product_controller.dart';
import 'package:skincare_app/src/core/domain/products/prod_controller.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/features/home/edit_product.dart';
import '../../themes/tripple_rail.dart';

class ProductListView extends ConsumerStatefulWidget {
  const ProductListView({super.key});

  @override
  ConsumerState<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends ConsumerState<ProductListView> {
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
          // final products = ref.watch(productControllerProvider);

          // final productList = products.value ?? [];

          return ref.watch(loadProductsProvider).when(
              data: (data) => data!= null ? data.isEmpty
                  ? const Center(
                      child: Text('There are no products'),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final product = data[index];
                          return Container(
                            height: 80,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            child: TrippleRail(
                              middle: const SizedBox(),
                              middleExpanded: true,
                              leadingExpanded: true,
                              leading: Row(
                                children: [
                                  if (product.image != null &&
                                      product.image!.isNotEmpty)
                                    Image.file(
                                      File(product.image!),
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                                  20.w.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(product.productName ??
                                          'Unknown Product'),
                                      10.h.verticalSpace,
                                      Text(product.productBrand ??
                                          'Unknown Brand'),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    EditProductView(
                                                      product: product,
                                                    )));
                                      },
                                      icon: ref.watch(loadProductsProvider).isLoading
                                          ? CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          : const Icon(
                                              CupertinoIcons.pencil,
                                              color: AppColors.primaryColor,
                                            )),
                                  IconButton(
                                    onPressed: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  AppColors.lightGreen,
                                              title: Text(
                                                'Delete',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              content: Text(
                                                'Are you sure you want to delete this product?',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      final productController =
                                                          ref.read(
                                                              deleteProductControllerProvider
                                                                  .notifier);
                                                      await productController
                                                          .deleteProduct(
                                                              id: product.id!,
                                                              afterFetched: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop());
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'No',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                    ))
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ) : const Center(child: Text('Error loading products'),),
              error: (e, s) => Center(
                    child: Text('Error occured: $e'),
                  ),
              loading: () => const CircularProgressIndicator());
        },
      ),
    );
  }
}
