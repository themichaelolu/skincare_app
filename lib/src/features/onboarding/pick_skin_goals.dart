import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/features/onboarding/build_routine.dart';
import 'package:skincare_app/src/features/onboarding/pick_skin_type.dart';

import 'onboarding.dart';

class PickSkinGoalsView extends StatefulWidget {
  const PickSkinGoalsView({
    super.key,
    this.goBack,
    this.goToBuildRoutine,
  });
  final VoidCallback? goBack;
  final VoidCallback? goToBuildRoutine;

  @override
  State<PickSkinGoalsView> createState() => _PickSkinGoalsViewState();
}

class _PickSkinGoalsViewState extends State<PickSkinGoalsView> {
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          onTap: () => widget.goBack?.call(),
          child: Align(
            heightFactor: 1,
            widthFactor: 1,
            child: SvgPicture.asset(
              AppAssets.back,
            ),
          ),
        ),
        centerTitle: true,
        title: IndicatorWidget(
          fullWidth: 200.w,
          index: 2,
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
              ),
            ),
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
              'What\'s your skin goals?',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            5.h.verticalSpace,
            Text(
              '(You can select more than one)',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            20.h.verticalSpace,
            Expanded(
                child: ListView.builder(
              itemCount: skinGoals.length,
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
                        skinGoals[index],
                      ),
                    ),
                  ),
                );
              },
            )),
            ButtonWidget(
              height: 45.h,
              width: screenSize(context).width,
              onTap: () => Navigator.of(context)
                  .pushReplacement(CupertinoPageRoute(builder: (context) {
                return const BuildRoutineView();
              })),
              color: AppColors.primaryColor,
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
