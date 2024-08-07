import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/features/cart/checkout.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key});

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends State<OrderSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
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
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.check),
                          7.w.horizontalSpace,
                          const Text('Review'),
                        ],
                      ),
                    ],
                  )),
            ),
            120.h.verticalSpace,
            SvgPicture.asset(AppAssets.success),
            20.h.verticalSpace,
            Text(
              'Your order has been placed!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            11.h.verticalSpace,
            Text(
              'Order no: #4050004',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            45.h.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: ButtonWidget(
                height: 45.h,
                width: screenSize(context).width,
                color: AppColors.primaryColor,
                child: Center(
                  child: Text(
                    'Continue Shopping',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
