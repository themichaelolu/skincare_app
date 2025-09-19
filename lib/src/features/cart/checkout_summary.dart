import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/domain/cart/providers.dart';
import 'package:skincare_app/src/core/domain/shipping_info/provider.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/features/cart/checkout.dart';
import 'package:skincare_app/src/features/cart/order_success.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';

class CheckOutSummaryView extends ConsumerStatefulWidget {
  const CheckOutSummaryView({super.key});

  @override
  ConsumerState<CheckOutSummaryView> createState() =>
      _CheckOutSummaryViewState();
}

class _CheckOutSummaryViewState extends ConsumerState<CheckOutSummaryView> {
  @override
  Widget build(BuildContext context) {
    final ship = ref.watch(shippingInfoProvider);
    final cart = ref.watch(cartProvider);
    final productQuantities = cart.productQuantity();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 29,
        ),
        child: ButtonWidget(
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const OrderSuccessView(),
            ),
          ),
          height: 45.h,
          width: screenSize(context).width,
          color: AppColors.primaryColor,
          child: Center(
            child: Text(
              'Submit Order',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: TrippleRail(
                leading: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(AppAssets.back),
                ),
                trailExpanded: true,
                leadingExpanded: true,
                middle: Text(
                  'Checkout',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),
            15.h.verticalSpace,
            Container(
              height: 55.h,
              width: screenSize(context).width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.check),
                          7.w.horizontalSpace,
                          const Text('Shipping'),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.check),
                          7.w.horizontalSpace,
                          const Text('Payment'),
                        ],
                      ),
                      const ContainerInWidget(
                        color: AppColors.textGreyColor,
                        text: 'Review',
                        number: '3',
                      ),
                    ],
                  )),
            ),
            13.h.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: 235.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productQuantities.length,
                      itemBuilder: (context, index) {

                        final product = productQuantities.keys.elementAt(index);
                        final quantity = productQuantities[product];
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Image(
                                image: const AssetImage(
                                  AppAssets.product,
                                ),
                                height: 52.h,
                                width: 52.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${product.productName}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Text(
                                      '${product.productBrand}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppColors.textGreyColor,
                                          ),
                                    ),
                                    Text('${product.price} x$quantity',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  13.h.verticalSpace,
                  Text(
                    'Shipping Info',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  13.h.verticalSpace,
                  Container(
                    height: 91.h,
                    width: screenSize(context).width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.textGreyColor,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 225.w,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ship.first.name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(ship.first.phoneNumber.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ]),
                              ),
                              SizedBox(
                                width: 181.w,
                                child: Text(
                                  ship.first.streetAddress ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  13.h.verticalSpace,
                  Text(
                    'Delivery Method',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  13.h.verticalSpace,
                  ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: const BorderSide(color: AppColors.textGreyColor)),
                    leading: SvgPicture.asset(AppAssets.instant),
                    title: Text(
                      'Instant Delivery',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('30-60 minutes'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                  13.h.verticalSpace,
                  Text(
                    'Payment',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  13.h.verticalSpace,
                  Container(
                    height: 45,
                    width: screenSize(context).width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.textGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Debit Card'),
                          SvgPicture.asset(
                            AppAssets.mastercard,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}



