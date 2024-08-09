import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:skincare_app/src/core/domain/products/provider.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/features/home/product_detail.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';

class HomeBaseView extends StatefulWidget {
  const HomeBaseView({
    super.key,
    this.goToDetails,
  });

  final VoidCallback? goToDetails;

  @override
  State<HomeBaseView> createState() => _HomeBaseViewState();
}

class _HomeBaseViewState extends State<HomeBaseView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  final List<Image> images = [
    Image.asset(
      AppAssets.promoPic,
    ),
    Image.asset(
      AppAssets.promoPic,
    ),
    Image.asset(
      AppAssets.promoPic,
    ),
    Image.asset(
      AppAssets.promoPic,
    ),
    Image.asset(
      AppAssets.promoPic,
    ),
    Image.asset(
      AppAssets.promoPic,
    ),
  ];

  int activePic = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            TrippleRail(
              leading: Row(
                children: [
                  CircleAvatar(
                    radius: 20.w,
                    backgroundColor: AppColors.primaryColor,
                  ),
                  10.w.horizontalSpace,
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey there Collette!',
                      ),
                      Text('Good morning ⛅')
                    ],
                  )
                ],
              ),
              trailing: const Icon(Icons.notifications),
              trailExpanded: true,
            ),
            20.h.verticalSpace,
            Container(
              height: 45,
              width: screenSize(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: AppColors.textGreyColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: TrippleRail(
                  leading: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.search,
                      ),
                      10.w.horizontalSpace,
                      Text(
                        'Search for anything',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textGreyColor,
                            ),
                      ),
                    ],
                  ),
                  trailExpanded: true,
                  trailing: SizedBox(
                    width: 51.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(AppAssets.filter),
                        SvgPicture.asset(AppAssets.scan),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            15.h.verticalSpace,
            FlutterCarousel(
                items: images,
                options: CarouselOptions(
                  showIndicator: false,
                  height: 131.h,
                  viewportFraction: 0.9,
                  autoPlay: true,
                  initialPage: activePic,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activePic = index;
                    });
                  },
                )),
            15.h.verticalSpace,
            Center(
              child: SizedBox(
                width: 50.w,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: images.asMap().entries.map((entry) {
                      return Container(
                        height: 6.h,
                        width: 6.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activePic == entry.key
                              ? AppColors.primaryColor
                              : AppColors.textGreyColor,
                        ),
                      );
                    }).toList()),
              ),
            ),
            15.h.verticalSpace,
            TabWidget(tabController: tabController),
            21.h.verticalSpace,
            Expanded(
                child: TabBarView(controller: tabController, children: const [
              AllProductsTabView(),
              CleanserTabView(),
              TonerTabView(),
              MoisturiserTabView(),
              SerumTabView(),
              SunScreenTabView()
            ]))
          ],
        ),
      )),
    );
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: AppColors.textGreyColor,
      dividerColor: Theme.of(context).scaffoldBackgroundColor,
      indicatorColor: Colors.black,
      splashFactory: NoSplash.splashFactory,
      labelColor: Colors.black,
      tabs: const [
        Tab(
          text: 'All',
        ),
        Tab(
          text: 'Cleanser',
        ),
        Tab(
          text: 'Toner',
        ),
        Tab(
          text: 'Moisturiser',
        ),
        Tab(
          text: 'Serum',
        ),
        Tab(
          text: 'Sunscreen',
        ),
      ],
      controller: tabController,
    );
  }
}

class AllProductsTabView extends ConsumerStatefulWidget {
  const AllProductsTabView({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  ConsumerState<AllProductsTabView> createState() => _AllProductsTabViewState();
}

class _AllProductsTabViewState extends ConsumerState<AllProductsTabView> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16),
      itemBuilder: (context, index) {
        final product = products[index];
        return InkWell(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ProductDetailView(
                  product: products[index],
                ),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(product.image!),
              8.h.verticalSpace,
              Text(
                product.productBrand ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.darkGreen,
                    ),
              ),
              4.h.verticalSpace,
              Text(
                product.productName ?? '',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                NumberFormat.decimalPattern().format(product.price),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CleanserTabView extends StatelessWidget {
  const CleanserTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TonerTabView extends StatelessWidget {
  const TonerTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MoisturiserTabView extends StatelessWidget {
  const MoisturiserTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SerumTabView extends StatelessWidget {
  const SerumTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SunScreenTabView extends StatelessWidget {
  const SunScreenTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
