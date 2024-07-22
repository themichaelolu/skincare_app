import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';

class CartBaseView extends StatefulWidget {
  const CartBaseView({super.key});

  @override
  State<CartBaseView> createState() => _CartBaseViewState();
}

class _CartBaseViewState extends State<CartBaseView> {
  int quantity = 0;

  void incrementQty() {
    setState(() {
      if (quantity < 11) {
        quantity++;
      }
    });
    if (kDebugMode) {
      print('QTY:;$quantity');
    }
  }

  void decrementQty() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
    });
    if (kDebugMode) {
      print('QTY:;$quantity');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        leading: Align(
          heightFactor: 1,
          widthFactor: 1,
          child: InkWell(
            child: SvgPicture.asset(
              AppAssets.back,
              colorFilter: const ColorFilter.mode(
                AppColors.darkGreen,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        child: Column(
          children: [
            SizedBox(
              height: 416.h,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    height: 95.h,
                    width: screenSize(context).width,
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
                            child: const Image(
                              color: AppColors.textGreyColor,
                              image: AssetImage(AppAssets.product),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Black Rice Hyaluronic Toner',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                6.h.verticalSpace,
                                Text(
                                  'Haruharu Wonder - 200ml',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColors.textGreyColor,
                                      ),
                                ),
                                6.h.verticalSpace,
                                Text(
                                  'N12,500',
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
                                    onTap: () => decrementQty,
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
                                    onTap: () => incrementQty,
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
            Spacer(),
            ButtonWidget(
              height: 45.h,
              width: screenSize(context).width,
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
    );
  }
}
