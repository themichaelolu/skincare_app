import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';

import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/features/home/product_detail.dart';

import 'package:skincare_app/src/themes/tripple_rail.dart';

import '../domain/products/prod_controller.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final WidgetRef ref;

  CustomSearchDelegate(this.ref);

  // // @override
  // // ThemeData appBarTheme(BuildContext context) {
  // //   return ThemeData(

  // //     appBarTheme: AppBarTheme(
  // //       elevation: 0,
  // //       color: Theme.of(context).scaffoldBackgroundColor,

  // //       //app bar color I wanted
  // //     ),
  // //     scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
  // //     searchBarTheme: SearchBarThemeData(

  // //     )
  // //   );
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          CupertinoIcons.delete,
          color: AppColors.primaryColor,
          size: 19,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.primaryColor,
          size: 19,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final products = ref.watch(loadProductsProvider);
    final product = products.value;
    final searchResult = product!
        .where((item) => item.productName!.contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => ProductDetailView(
              product: searchResult[index],
            ),
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: SearchTrippleRaiil(searchResult: searchResult[index]),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final products = ref.watch(loadProductsProvider);
    final product = products.value;
    final List<Product> queryList = query.isEmpty
        ? []
        : product!
            .where((item) => item.productName!.contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
        itemCount: queryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: InkWell(
              onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => ProductDetailView(
                  product: queryList[index],
                ),
              )),
              child: SearchTrippleRaiil(searchResult: queryList[index]),
            ),
          );
        });
  }
}

class SearchTrippleRaiil extends StatelessWidget {
  const SearchTrippleRaiil({
    super.key,
    required this.searchResult,
  });

  final Product searchResult;

  @override
  Widget build(BuildContext context) {
    return TrippleRail(
      middle: const SizedBox(),
      middleExpanded: true,
      leadingExpanded: true,
      leading: Row(
        children: [
          if (searchResult.image != null && searchResult.image!.isNotEmpty)
            Image.file(
              File(searchResult.image!),
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
          20.w.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(searchResult.productName ?? 'Unknown Product'),
              10.h.verticalSpace,
              Text(searchResult.productBrand ?? 'Unknown Brand'),
            ],
          ),
        ],
      ),
      trailExpanded: true,
      trailing: Text(
        NumberFormat.decimalPattern().format(searchResult.price),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
      ),
    );
  }
}
