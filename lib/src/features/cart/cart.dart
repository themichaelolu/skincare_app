import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:skincare_app/src/core/domain/cart/providers.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/cart/checkout.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';

class CartBaseView extends ConsumerStatefulWidget {
  const CartBaseView({super.key});

  @override
  ConsumerState<CartBaseView> createState() => _CartBaseViewState();
}

class _CartBaseViewState extends ConsumerState<CartBaseView> {
  int doubleQuantity(int quantity, int price) {
    return quantity > 1 ? price * quantity : price;
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final productQuantities = cart.productQuantity();

    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'My Cart',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
        leading: const SizedBox(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: Column(
            children: [
              SizedBox(
                height: 416.h,
                child: ListView.builder(
                  itemCount: productQuantities.length,
                  itemBuilder: (context, index) {
                    final product = productQuantities.keys.elementAt(index);
                    final quantity = productQuantities[product];
                    return Container(
                      margin: const EdgeInsets.all(10),
                      height: 95.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 83.h,
                              width: 75.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image(
                                image: AssetImage(
                                  product.images.first.smallPicture!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.productName ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  6.h.verticalSpace,
                                  Text(
                                    product.productBrand ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: AppColors.textGreyColor,
                                        ),
                                  ),
                                  6.h.verticalSpace,
                                  Text(
                                    NumberFormat.decimalPattern().format(
                                        doubleQuantity(
                                            quantity!, product.price!.toInt())),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              child: SizedBox(
                                width: 57.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          cart.removeProduct(product);
                                        });
                                      },
                                      child: Container(
                                        height: 16.h,
                                        width: 16.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.textGreyColor,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            CupertinoIcons.minus,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          cart.addProduct(product);
                                        });
                                      },
                                      child: Container(
                                        height: 16.h,
                                        width: 16.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.textGreyColor,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              15.h.verticalSpace,
              TextFieldWidget(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                  ),
                  child: SvgPicture.asset(AppAssets.voucher),
                ),
                fillColor: AppColors.white,
                filled: true,
                hintText: 'Enter discount code',
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: ButtonWidget(
                    height: 35.h,
                    width: 70.w,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Apply',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
              10.h.verticalSpace,
              ButtonWidget(
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => const CheckoutView(),
                )),
                height: 45.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.primaryColor,
                child: Center(
                  child: Text(
                    'Proceed to checkout',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
