import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({
    super.key,
    this.goToSignUp,
  });

  final VoidCallback? goToSignUp;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
  {
  late PageController _controller;

  int currentIndex = 0;

  @override
  void initState() {
    _controller = PageController();
   
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Widget> onboardingPics = const [
    Image(
      image: AssetImage(AppAssets.onboarding1),
    ),
    Image(
      image: AssetImage(AppAssets.onboarding2),
    ),
    Image(
      image: AssetImage(AppAssets.onboarding3),
    ),
  ];

  void _handlePageViewChanged(int currentPageIndex) {
  
    setState(() {
      currentIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {

    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  InkWell(
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 355.h,
                child: PageView(
                  controller: _controller,
                  onPageChanged: _handlePageViewChanged,
                  children: onboardingPics,
                ),
              ),
              Center(
                child: SizedBox(
                    width: 55.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: onboardingPics
                          .asMap()
                          .entries
                          .map((e) => Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: currentIndex == e.key
                                        ? Border.all(
                                            color: AppColors.primaryColor,
                                          )
                                        : null),
                                child: Container(
                                  height: 8,
                                  width: 8,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ))
                          .toList(),
                    )),
              ),
              20.h.verticalSpace,
              if (currentIndex == 0)
                const OnboardingText(
                    headText: 'Authentic Products',
                    subText: 'Discover & get your authentic beauty\nprodcuts'),
              if (currentIndex == 1)
                const OnboardingText(
                  headText: 'Expert Guidance',
                  subText:
                      'Not sure what to get? Schedule a consultation\nwith a dermatologist',
                ),
              if (currentIndex == 2)
                const OnboardingText(
                  headText: 'Tailored Suggestions',
                  subText:
                      'Recommendations curated just for you to fit\nyour skin type and needs',
                ),
              20.h.verticalSpace,
              ButtonWidget(
                height: 45.h,
                width: screenSize(context).width,
                color: AppColors.primaryColor,
                onTap: () {
                  if (currentIndex < 2) {
                    _updateCurrentPageIndex(currentIndex + 1);
                  } else {
                    widget.goToSignUp?.call();
                  }
                },
                child: Text(
                  currentIndex < 2 ? 'Continue' : 'Get Started',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingText extends StatelessWidget {
  const OnboardingText({
    super.key,
    required this.headText,
    required this.subText,
  });

  final String headText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          headText,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            fontFamily: 'Playfair',
          ),
        ),
        5.h.verticalSpace,
        Text(
          subText,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.height,
    this.width,
    this.color,
    this.onTap,
    this.border,
    this.child,
  });

  final double? height;
  final double? width;
  final Color? color;

  final void Function()? onTap;
  final BoxBorder? border;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          border: border,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
