import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/features/cart/cart.dart';
import 'package:skincare_app/src/features/cart/liked_products.dart';
import 'package:skincare_app/src/features/explore/explore.dart';
import 'package:skincare_app/src/features/home/home.dart';

import 'src/core/utils/app_assets/app_assets.dart';

class DashboardBaseView extends StatefulWidget {
  const DashboardBaseView({
    super.key,
    this.goToHome,
    this.goToCart,
    this.goToExplore,
    this.goToLikedProducts,

  });

  final VoidCallback? goToHome;
  final VoidCallback? goToExplore;
  final VoidCallback? goToCart;
  final VoidCallback? goToLikedProducts;


  @override
  State<DashboardBaseView> createState() => _DashboardBaseViewState();
}

class _DashboardBaseViewState extends State<DashboardBaseView> {
  int _selectedIndex = 0;

  /// used to to move to the tapped index of the bottom nav

  static const List<Widget> pages = [
    HomeBaseView(),
    ExploreView(),
    CartBaseView(),
    LikedProductsView(),
  ];
  void _selectedTab(index) {
    setState(() {
      _selectedIndex = index;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 25,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BottomNavigationBar(
              backgroundColor: AppColors.primaryColor,
              selectedItemColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _selectedTab,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppAssets.home,
                    colorFilter: const ColorFilter.mode(
                        AppColors.textGreyColor, BlendMode.srcIn),
                  ),
                  label: '',
                  activeIcon: SvgPicture.asset(
                    AppAssets.home,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppAssets.explore,
                  ),
                  label: '',
                  activeIcon: SvgPicture.asset(
                    AppAssets.explore,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppAssets.cart,
                  ),
                  label: '',
                  activeIcon: SvgPicture.asset(
                    AppAssets.cart,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppAssets.liked,
                  ),
                  label: '',
                  activeIcon: SvgPicture.asset(
                    AppAssets.liked,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: pages.elementAt(_selectedIndex),);
  }
}
