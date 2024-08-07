import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/string_extensions.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/cart/card.dart';
import 'package:skincare_app/src/features/cart/checkout.dart';
import 'package:skincare_app/src/features/cart/checkout_summary.dart';
import 'package:skincare_app/src/features/cart/payment.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';

class CheckOutPaymentView extends StatefulWidget {
  const CheckOutPaymentView({super.key});

  @override
  State<CheckOutPaymentView> createState() => _CheckOutPaymentViewState();
}

class _CheckOutPaymentViewState extends State<CheckOutPaymentView> {
  String? selectedPayment;
  final nameOnCardCtrl = TextEditingController();
  final cardNumberCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final cvvCtrl = TextEditingController();
  final _paymentCard = PaymentCard();
  String? myEntry = '';
  bool isSaved = false;

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    cardNumberCtrl.removeListener(_getCardTypeFrmNumber);
    cardNumberCtrl.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(cardNumberCtrl.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    cardNumberCtrl.addListener(_getCardTypeFrmNumber);
  }

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
            builder: (context) => const CheckOutSummaryView(),
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
                        const ContainerInWidget(
                          color: Colors.black,
                          text: 'Payment',
                          number: '2',
                        ),
                        const ContainerInWidget(
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
                      'Please enter your payment information',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    20.h.verticalSpace,
                    RadioListTile<String?>(
                      tileColor: selectedPayment == 'Card'
                          ? AppColors.lightGreen
                          : null,
                      value: 'Card',
                      toggleable: true,
                      activeColor: AppColors.primaryColor,
                      title: Text(
                        'Credit or debit card',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: selectedPayment == 'Card'
                                ? AppColors.primaryColor
                                : AppColors.textGreyColor,
                          )),
                      groupValue: selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                      },
                      fillColor: const MaterialStatePropertyAll(
                        AppColors.primaryColor,
                      ),
                      selectedTileColor: AppColors.lightGreen,
                      secondary: SizedBox(
                        width: 60.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(AppAssets.visa),
                            SvgPicture.asset(AppAssets.mastercard),
                          ],
                        ),
                      ),
                    ),
                    10.h.verticalSpace,
                    RadioListTile<String?>(
                      tileColor: selectedPayment == 'Bank'
                          ? AppColors.lightGreen
                          : null,
                      value: 'Bank',
                      toggleable: true,
                      activeColor: AppColors.primaryColor,
                      title: Text(
                        'Bank Transfer',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: selectedPayment == 'Bank'
                                ? AppColors.primaryColor
                                : AppColors.textGreyColor,
                          )),
                      groupValue: selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                      },
                      fillColor: const MaterialStatePropertyAll(
                        AppColors.primaryColor,
                      ),
                      selectedTileColor: AppColors.lightGreen,
                      secondary: SvgPicture.asset(AppAssets.transfer),
                    ),
                    10.h.verticalSpace,
                    RadioListTile<String?>(
                      tileColor: selectedPayment == 'Apple Pay'
                          ? AppColors.lightGreen
                          : null,
                      value: 'Apple Pay',
                      toggleable: true,
                      activeColor: AppColors.primaryColor,
                      title: Text(
                        'Apple Pay',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: selectedPayment == 'Apple Pay'
                                ? AppColors.primaryColor
                                : AppColors.textGreyColor,
                          )),
                      groupValue: selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                      },
                      fillColor: const MaterialStatePropertyAll(
                        AppColors.primaryColor,
                      ),
                      selectedTileColor: AppColors.lightGreen,
                      secondary: SvgPicture.asset(AppAssets.applePay),
                    ),
                    25.h.verticalSpace,
                    const Divider(
                      color: AppColors.textGreyColor,
                    ),
                    15.h.verticalSpace,
                    if (selectedPayment == 'Card')
                      Column(
                        children: [
                          TextFieldWidget(
                            labelText: 'Card Number',
                            hintText: '0000 0000 0000 0000',
                            validator: CardUtils.validateCardNum,
                            prefixIcon:
                                CardUtils.getCardIcon(_paymentCard.type),
                            onChanged: (value) {
                              _paymentCard.number =
                                  CardUtils.getCleanedNumber(value);
                            },
                            controller: cardNumberCtrl,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                              CardNumberFormatter()
                            ],
                          ),
                          12.h.verticalSpace,
                          TextFieldWidget(
                            labelText: 'Card holder name',
                            hintText: 'Please enter your full name',
                            controller: nameOnCardCtrl,
                          ),
                          12.h.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenSize(context).width * 0.4,
                                child: TextFieldWidget(
                                  labelText: 'Expiry Date',
                                  hintText: 'MM/YY',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                    CardMonthInputFormatter()
                                  ],
                                  controller: expCtrl,
                                  validator: CardUtils.validateDate,
                                  onSaved: (value) {
                                    List<int> expiryDate =
                                        CardUtils.getExpiryDate(value!);
                                    _paymentCard.month = expiryDate[0];
                                    _paymentCard.year = expiryDate[1];
                                  },
                                ),
                              ),
                              SizedBox(
                                width: screenSize(context).width * 0.4,
                                child: TextFieldWidget(
                                  labelText: 'CVV',
                                  hintText: '000',
                                  validator: CardUtils.validateCVV,
                                  controller: cvvCtrl,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  onSaved: (value) {
                                    _paymentCard.cvv = int.parse(value!);
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            ],
                          ),
                          13.h.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Save information for next time',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              CupertinoSwitch(
                                activeColor: AppColors.primaryColor,
                                value: isSaved,
                                onChanged: (value) {
                                  setState(() {
                                    isSaved = value;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    if (selectedPayment == 'Bank')
                      Center(
                        child: ButtonWidget(
                          height: 45.h,
                          width: 200.w,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'Proceed',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    if (selectedPayment == 'Apple Pay')
                      Center(
                        child: ButtonWidget(
                          height: 45.h,
                          width: 200.w,
                          border: Border.all(color: AppColors.textGreyColor),
                          child: Center(
                              child: SvgPicture.asset(
                            AppAssets.applePay,
                          )),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
