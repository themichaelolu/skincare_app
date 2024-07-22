import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:skincare_app/src/core/domain/cart/providers.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';
import 'package:skincare_app/src/core/domain/products/provider.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';

class ProductDetailView extends ConsumerStatefulWidget {
  const ProductDetailView({
    super.key,
    this.goToCart,
     this.product,
  });

  final VoidCallback? goToCart;
  final Product? product;
  

  @override
  ConsumerState<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends ConsumerState<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.read(cartProvider.notifier);

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
              onTap: () {
                Flushbar(
                  title: 'Success!',
                  icon: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.darkGreen,
                    ),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.check_mark,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  message: 'Item added Successfully!',
                );
                cart.addProduct(widget.product!);
              },
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
                    widget.product?.images.first.bigPicture ?? ''
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
                     widget.product?.productBrand ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.darkGreen,
                          ),
                    ),
                    Text(
                      '★ ${widget.product?.reviewCount}Reviews',
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
                      widget.product?.productName ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                  NumberFormat.decimalPattern().format(widget.product?.price),
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
