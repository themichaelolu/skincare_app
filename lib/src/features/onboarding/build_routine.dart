import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/dashboard.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';

import 'onboarding.dart';
import 'pick_skin_type.dart';

class BuildRoutineView extends StatefulWidget {
  const BuildRoutineView({
    super.key,
    this.goBack,
    this.goHome,
  });

  final VoidCallback? goBack;
  final VoidCallback? goHome;

  @override
  State<BuildRoutineView> createState() => _BuildRoutineViewState();
}

class _BuildRoutineViewState extends State<BuildRoutineView> {
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
          index: 3,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Build your skincare routine',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            5.h.verticalSpace,
            Center(
              child: Text(
                'You can select more than one',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            20.h.verticalSpace,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 7,
                mainAxisSpacing: 17,
                childAspectRatio: 3,
                children: const [
                  CardWidget(
                    assetName: AppAssets.hygiene,
                    title: 'Cleanser',
                  ),
                  CardWidget(
                    assetName: AppAssets.toner,
                    title: 'Toner',
                  ),
                  CardWidget(
                    assetName: AppAssets.moisturiser,
                    title: 'Moisturiser',
                  ),
                  CardWidget(
                    assetName: AppAssets.serum1,
                    title: 'Serum',
                  ),
                  CardWidget(
                    assetName: AppAssets.serum2,
                    title: 'Ampoule',
                  ),
                  CardWidget(
                    assetName: AppAssets.sheetMask,
                    title: 'Sheet masks',
                  ),
                  CardWidget(
                    assetName: AppAssets.sunCream,
                    title: 'Suncare',
                  ),
                  CardWidget(
                    assetName: AppAssets.eyeCream,
                    title: 'Eye Cream',
                  ),
                  CardWidget(
                    assetName: AppAssets.bodyScrub,
                    title: 'Body Scrub',
                  ),
                  CardWidget(
                    assetName: AppAssets.lotion,
                    title: 'Body lotion',
                  ),
                  CardWidget(
                    assetName: AppAssets.bodyWash,
                    title: 'Body wash',
                  ),
                  CardWidget(
                    assetName: AppAssets.lipBalm,
                    title: 'Lip Care',
                  ),
                  CardWidget(
                    assetName: AppAssets.faceRoller,
                    title: 'Beauty Tools',
                  ),
                ],
              ),
            ),
            ButtonWidget(
              height: 45.h,
              width: screenSize(context).width,
              onTap: () => Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const DashboardBaseView(),
                  )),
              color: AppColors.primaryColor,
              child: Center(
                child: Text(
                  'Let\'s go!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, this.title, required this.assetName});

  final String? title;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.textGreyColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetName,
          ),
          5.w.horizontalSpace,
          Text(
            title ?? '',
          )
        ],
      ),
    );
  }
}
