import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/features/cart/checkout.dart';
import 'package:skincare_app/src/features/cart/payment.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';

class ConfirmShippingView extends StatefulWidget {
  const ConfirmShippingView({super.key});

  @override
  State<ConfirmShippingView> createState() => _ConfirmShippingViewState();
}

class _ConfirmShippingViewState extends State<ConfirmShippingView> {
  bool isInstant = false;
  bool isStandard = false;
  bool isInterState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 29,
        ),
        child: ButtonWidget(
          onTap: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => const CheckOutPaymentView(),
          )),
          height: 45.h,
          width: screenSize(context).width,
          color: AppColors.primaryColor,
          child: Center(
            child: Text(
              'Continue',
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
              child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ContainerInWidget(
                        color: Colors.black,
                        text: 'Shipping',
                        number: '1',
                      ),
                      ContainerInWidget(
                        color: AppColors.textGreyColor,
                        text: 'Payment',
                        number: '2',
                      ),
                      ContainerInWidget(
                        color: AppColors.textGreyColor,
                        text: 'Review',
                        number: '3',
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.h.verticalSpace,
                  Text(
                    'Please enter your shipping information',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  23.h.verticalSpace,
                  Container(
                    height: 128.h,
                    width: screenSize(context).width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.textGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shipping information',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              InkWell(
                                child: Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.blue,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.textGreyColor,
                                    ),
                              ),
                              Text('Hilary',
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Street Address',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.textGreyColor,
                                    ),
                              ),
                              Text('124 ABC Drive',
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'City',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.textGreyColor,
                                    ),
                              ),
                              Text('Lagos',
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  23.h.verticalSpace,
                  Text(
                    'Delivery method',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  23.h.verticalSpace,
                  DeliveryMethodWidget(
                    assetName: AppAssets.instant,
                    subTitle: '30 - 60 minutes',
                    title: 'Instant Delivery',
                    isSelect: isInstant,
                    onTap: () {
                      setState(() {
                        isInstant = !isInstant;
                      });
                    },
                  ),
                  23.h.verticalSpace,
                  DeliveryMethodWidget(
                    assetName: AppAssets.standard,
                    subTitle: '24 - 48 hours',
                    title: 'Standard Delivery',
                    isSelect: isStandard,
                    onTap: () {
                      setState(() {
                        isStandard = !isStandard;
                      });
                    },
                  ),
                  23.h.verticalSpace,
                  DeliveryMethodWidget(
                    assetName: AppAssets.interstate,
                    subTitle: '3 - 7 days',
                    title: 'Interstate Delivery',
                    isSelect: isInterState,
                    onTap: () {
                      setState(() {
                        isInterState = !isInterState;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class DeliveryMethodWidget extends StatefulWidget {
  const DeliveryMethodWidget({
    super.key,
    this.assetName,
    this.isSelect = false,
    this.onTap,
    this.title,
    this.subTitle,
  });

  final String? assetName;
  final bool? isSelect;
  final void Function()? onTap;
  final String? title;
  final String? subTitle;

  @override
  State<DeliveryMethodWidget> createState() => _DeliveryMethodWidgetState();
}

class _DeliveryMethodWidgetState extends State<DeliveryMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      tileColor: widget.isSelect == true ? AppColors.lightGreen : null,
      splashColor: AppColors.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: BorderSide(
          color: widget.isSelect == true
              ? AppColors.primaryColor
              : AppColors.textGreyColor,
        ),
      ),
      leading: SvgPicture.asset(widget.assetName!),
      title: Text(
        widget.title ?? '',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(
        widget.subTitle ?? '',
        style: const TextStyle(
          fontSize: 11,
        ),
      ),
    );
  }
}
