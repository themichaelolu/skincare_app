
import 'package:flutter/material.dart';

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
  void _goBranch(int index) {
    switch (index) {
      case 0:
        widget.goToHome!.call();
        break;
      case 1:
        widget.goToExplore!.call();
        break;
      case 2:
        widget.goToExplore!.call();
        break;
      case 3:
        widget.goToLikedProducts!.call();
        break;
      default:
    }
  }

  void _selectedTab(index) {
    setState(() {
      _selectedIndex = index;
    });
    _goBranch(_selectedIndex);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 29,), child: BottomNavigationBar(items: []),),
    );
  }
}
