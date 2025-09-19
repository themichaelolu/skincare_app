import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/features/onboarding/pick_skin_goals.dart';

class PickSkinTypeView extends StatefulWidget {
  const PickSkinTypeView({
    super.key,
    this.goToSkinGoals,
  });

  final VoidCallback? goToSkinGoals;

  @override
  State<PickSkinTypeView> createState() => _PickSkinTypeViewState();
}

class _PickSkinTypeViewState extends State<PickSkinTypeView> {
  final List<String> skinTypes = [
    'Normal Skin',
    'Dry skin',
    'Oily Skin',
    'Combination Skin',
    'Sensitive Skin',
  ];

  final List<String> skinGoals = [
    'Clear Breakouts',
    'Minimise pores',
    'Minimise oilness',
    'Reduce redness',
    'Maximise hydration',
    'Even skin tone',
    'Fewer dry or rough patches',
    'Optimize skin barrier',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: IndicatorWidget(
          fullWidth: 200.w,
          index: 1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: InkWell(
                child: Text(
              'Skip',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.primaryColor),
            )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Text(
              'What\'s your skin type?',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            5.h.verticalSpace,
            Text(
              '(P.S: It\'s okay if you don\'t know we\'ll help you figure it out)',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            20.h.verticalSpace,
            Expanded(
                child: ListView.builder(
              itemCount: skinTypes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: ButtonWidget(
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                    height: 45.h,
                    width: screenSize(context).width,
                    child: Center(
                      child: Text(
                        skinTypes[index],
                      ),
                    ),
                  ),
                );
              },
            )),
            ButtonWidget(
              height: 45.h,
              width: screenSize(context).width,
              color: AppColors.primaryColor,
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const PickSkinGoalsView())),
              child: Center(
                child: Text(
                  'Continue',
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

class IndicatorWidget extends StatefulWidget {
  const IndicatorWidget({super.key, this.index, this.fullWidth = 200});

  final int? index;
  final double? fullWidth;

  @override
  State<IndicatorWidget> createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends State<IndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 3.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.textGreyColor,
        ),
        width: widget.fullWidth,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 3.h,
            width: childWidth(widget.index!, widget.fullWidth!),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.primaryColor),
          ),
        ));
  }

  double childWidth(int pageNumber, double fullWidth) {
    if (pageNumber == 1) {
      return 65;
    }
    if (pageNumber == 2) {
      return 130;
    } else {
      return fullWidth;
    }
  }
}
