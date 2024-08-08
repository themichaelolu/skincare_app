import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/domain/shipping_info/db_helper.dart';
import 'package:skincare_app/src/core/domain/shipping_info/shipping_info.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/small_drop.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/cart/confirm_shipping.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    this.shippingID,
  });

  final int? shippingID;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  DbHelper dbHelper = DbHelper.instance;

  // List<ShippingInfo> shippingInfo = [];

  final formKey = GlobalKey<FormState>();
  final checkOutNameCtrl = TextEditingController();
  final phoneNumCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final houseNoCtrl = TextEditingController();
  final postCodeCtrl = TextEditingController();

  String? selectedCities;
  String? selectedCountry;

  late ShippingInfo shippingInfo;
  refreshInfo() {
    if (widget.shippingID == null) {
      setState(() {
        isNewInfo = true;
      });
    }
    dbHelper.read(widget.shippingID!).then(
          (value) => setState(
            () {
              shippingInfo = value;
              checkOutNameCtrl.text = shippingInfo.name ?? '';
              phoneNumCtrl.text = shippingInfo.phoneNumber.toString();
              addressCtrl.text = shippingInfo.streetAddress ?? '';
              postCodeCtrl.text = shippingInfo.postcode.toString();
              houseNoCtrl.text = shippingInfo.houseNo.toString();
            },
          ),
        );
  }

  createNote() {
    setState(() {
      isLoading = true;
    });
    final info = ShippingInfo(
      name: checkOutNameCtrl.text,
      phoneNumber: int.parse(phoneNumCtrl.text),
      streetAddress: addressCtrl.text,
      postcode: int.parse(postCodeCtrl.text),
      houseNo: int.parse(houseNoCtrl.text),
    );
    if (isNewInfo) {
      dbHelper.create(info);
    } else {
      info.id = shippingInfo.id;
      dbHelper.update(info);
    }
    setState(() {
      isLoading = false;
    });
  }

  deleteNote() {
    dbHelper.delete(shippingInfo.id!);
  }

  @override
  void dispose() {
    dbHelper.closeDb();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  bool isNewInfo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 29,
        ),
        child: ButtonWidget(
          onTap: () {
            createNote();
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => const ConfirmShippingView(),
            ));
          },
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
        child: Form(
          key: formKey,
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
                    10.h.verticalSpace,
                    TextFieldWidget(
                      labelText: 'Name',
                      controller: checkOutNameCtrl,
                      hintText: 'Please enter your name',
                      filled: false,
                    ),
                    10.h.verticalSpace,
                    TextFieldWidget(
                      labelText: 'Phone number',
                      hintText: 'Please enter your phone number',
                      controller: phoneNumCtrl,
                      filled: false,
                    ),
                    10.h.verticalSpace,
                    TextFieldWidget(
                      labelText: 'Street address',
                      hintText: 'Please enter your street address',
                      controller: addressCtrl,
                      filled: false,
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
                                  selectedCities = value!;
                                });
                              },
                            ),
                          ],
                        )
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class ContainerInWidget extends StatelessWidget {
  const ContainerInWidget({
    super.key,
    this.color,
    this.number,
    this.text,
  });

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
        Text(text ?? '')
      ],
    );
  }
}
