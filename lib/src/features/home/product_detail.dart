import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key, this.goToCart,});

  final VoidCallback? goToCart;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 28,
          horizontal: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonWidget(
              border: Border.all(
                color: AppColors.primaryColor,
              ),
              height: 45.h,
              width: 155.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.cart,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  13.w.horizontalSpace,
                  Text(
                    'Add to Cart',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
            ButtonWidget(
              color: AppColors.primaryColor,
              onTap: () => widget.goToCart?.call(),
              height: 45.h,
              width: 155.w,
              child: Center(
                child: Text(
                  'Buy now',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColors.white),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 370.h,
                width: screenSize(context).width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: AppColors.white,
                ),
                child: Center(
                  child: Image.asset(
                    AppAssets.product,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 60,
                child: SvgPicture.asset(
                  AppAssets.back,
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
              ),
              Positioned(
                right: 24,
                top: 60,
                child: SvgPicture.asset(
                  AppAssets.like,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Harharu Wonder',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.darkGreen,
                          ),
                    ),
                    Text(
                      '★ 1,000 Reviews',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xffFBBC05),
                          ),
                    )
                  ],
                ),
                5.h.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Black Rice Hyaluronic Toner',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'N 14,000',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
