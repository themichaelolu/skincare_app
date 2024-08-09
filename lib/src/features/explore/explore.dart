import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/features/explore/add_product.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton.icon(
          label: const Text(
            'Click here to add a product',
            style: TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
          onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => const AddProductView(),
          )),
          icon: const Icon(
            Icons.add,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
