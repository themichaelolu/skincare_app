import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/domain/shipping_info/provider.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/small_drop.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/cart/confirm_shipping.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';

import '../onboarding/onboarding.dart';

class CheckoutView extends ConsumerStatefulWidget {
  const CheckoutView({super.key, this.shippingID});

  final int? shippingID;

  @override
  ConsumerState<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends ConsumerState<CheckoutView> {
  final formKey = GlobalKey<FormState>();
  final checkOutNameCtrl = TextEditingController();
  final phoneNumCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final houseNoCtrl = TextEditingController();
  final postCodeCtrl = TextEditingController();

  String? selectedCities;
  String? selectedCountry;
  bool isLoading = false;
  bool isNewInfo = false;

  @override
  void dispose() {
    checkOutNameCtrl.dispose();
    phoneNumCtrl.dispose();
    addressCtrl.dispose();
    houseNoCtrl.dispose();
    postCodeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 29),
        child: ButtonWidget(
          onTap: () {
            if (formKey.currentState?.validate() ?? false) {
              ref.read(shippingInfoProvider.notifier).addInfo(
                  checkOutNameCtrl.text,
                  int.parse(
                    phoneNumCtrl.text,
                  ),
                  addressCtrl.text,
                  int.parse(houseNoCtrl.text),
                  int.parse(postCodeCtrl.text));
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => const ConfirmShippingView(
                    // shippingInfo: shippingInfo,
                    ),
              ));
        
            }
          },
          height: 45.h,
          width: screenSize(context).width,
          color: AppColors.primaryColor,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                _buildStepIndicator(context),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                      10.h.verticalSpace,
                      _buildTextFields(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    return Container(
      height: 55.h,
      width: screenSize(context).width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
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
        ),
      ),
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldWidget(
          labelText: 'Name',
          controller: checkOutNameCtrl,
          hintText: 'Please enter your name',
          filled: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Name cannot be empty';
            }
            return null;
          },
        ),
        10.h.verticalSpace,
        TextFieldWidget(
          labelText: 'Phone number',
          hintText: 'Please enter your phone number',
          controller: phoneNumCtrl,
          filled: false,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number cannot be empty';
            }
            if (!RegExp(r'^\d+$').hasMatch(value)) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
        ),
        10.h.verticalSpace,
        TextFieldWidget(
          labelText: 'Street address',
          hintText: 'Please enter your street address',
          controller: addressCtrl,
          filled: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Street address cannot be empty';
            }
            return null;
          },
        ),
        10.h.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: screenSize(context).width * 0.4,
              child: TextFieldWidget(
                labelText: 'House no.',
                hintText: 'e.g 14',
                filled: false,
                keyboardType: TextInputType.number,
                controller: houseNoCtrl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'House number cannot be empty';
                  }
                  return null;
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'City',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                5.h.verticalSpace,
                SmallDropdownWidget(
                  hint: 'City',
                  width: screenSize(context).width * 0.4,
                  value: selectedCities,
                  items: const [
                    DropdownMenuItem(
                      value: 'Home',
                      child: Text('Home'),
                    ),
                    DropdownMenuItem(
                      value: 'Lagos',
                      child: Text('Lagos'),
                    ),
                    DropdownMenuItem(
                      value: 'Abuja',
                      child: Text('Abuja'),
                    ),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      selectedCities = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        10.h.verticalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Country',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            5.h.verticalSpace,
            SmallDropdownWidget(
              width: screenSize(context).width,
              value: selectedCountry,
              hint: 'Country',
              items: const [
                DropdownMenuItem(
                  value: 'Nigeria',
                  child: Text('Nigeria'),
                ),
                DropdownMenuItem(
                  value: 'United Kingdom',
                  child: Text('United Kingdom'),
                ),
                DropdownMenuItem(
                  value: 'United States',
                  child: Text('United States'),
                ),
              ],
              onChanged: (String? value) {
                setState(() {
                  selectedCountry = value!;
                });
              },
            ),
          ],
        ),
        10.h.verticalSpace,
        TextFieldWidget(
          labelText: 'Postcode (Optional)',
          hintText: '0000',
          filled: false,
          keyboardType: TextInputType.number,
          controller: postCodeCtrl,
        ),
      ],
    );
  }
}

class ContainerInWidget extends StatelessWidget {
  const ContainerInWidget({
    Key? key,
    this.color,
    this.number,
    this.text,
  }) : super(key: key);

  final Color? color;
  final String? number;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number ?? '',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        7.w.horizontalSpace,
        Text(text ?? ''),
      ],
    );
  }
}
