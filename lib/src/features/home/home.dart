import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:skincare_app/src/core/data/seaech_delegate.dart';
import 'package:skincare_app/src/core/domain/products/prod_controller.dart';
import 'package:skincare_app/src/core/domain/products/prod_db_helper.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';

import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/home/product_detail.dart';
import 'package:skincare_app/src/features/home/profle_view.dart';
import 'package:skincare_app/src/themes/tripple_rail.dart';


class HomeBaseView extends ConsumerStatefulWidget {
  const HomeBaseView({
    super.key,
    this.goToDetails,
  });

  final VoidCallback? goToDetails;

  @override
  ConsumerState<HomeBaseView> createState() => _HomeBaseViewState();
}

class _HomeBaseViewState extends ConsumerState<HomeBaseView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;


  ProductDatabaseHelper productDatabaseHelper = ProductDatabaseHelper();
  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  String _query = '';

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
    // final googleSignInController = ref.watch(googleSignInControllerProvider);

    return Scaffold(
      // drawer: Drawer(
      //   shape: const LinearBorder(),
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(
      //       vertical: 15,
      //     ),
      //     child: ListView(
      //       children: [
      //         const ListTile(
      //           leading: Icon(
      //             CupertinoIcons.person,
      //             color: AppColors.primaryColor,
      //           ),
      //           title: Text('Your profile'),
      //         ),
      //         ListTile(
      //           leading: const Icon(
      //             Icons.add,
      //             color: AppColors.primaryColor,
      //           ),
      //           title: const Text('Add a product'),
      //           onTap: () {
      //             Navigator.of(context)
      //                 .push(CupertinoPageRoute(builder: (context) {
      //               return const AddProductView();
      //             }));
      //           },
      //         ),
      //         ListTile(
      //             leading: const Icon(
      //               Icons.list,
      //               color: AppColors.primaryColor,
      //             ),
      //             title: const Text('Your list of products'),
      //             onTap: () {
      //               Navigator.of(context)
      //                   .push(CupertinoPageRoute(builder: (context) {
      //                 return const ProductListView();
      //               }));
      //             })
      //       ],
      //     ),
      //   ),
      // ),
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
                  InkWell(
                    onTap: () {
                      // _drawerKey.currentState?.openDrawer();
                      Navigator.of(context).push( CupertinoPageRoute(builder: (context) => const ProfileView(), ));
                    },
                    child: CircleAvatar(
                        radius: 20.w,
                        backgroundColor: AppColors.primaryColor,
                        child: Image.network(
                            'https://static.vecteezy.com/system/resources/previews/002/387/693/non_2x/user-profile-icon-free-vector.jpg')),
                  ),
                  10.w.horizontalSpace,
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey there User',
                      ),
                      Text('Good morning ⛅')
                    ],
                  )
                ],
              ),
              trailing: const Icon(Icons.notifications),
              trailExpanded: true,
            ),
            TextFieldWidget(
              readOnly: true,
              onTap: () async {
                await showSearch(
                    context: context, delegate: CustomSearchDelegate(ref));
              },
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Color(0xff787878),
              ),
              hintText: 'Search for anything',
              fillColor: Colors.white,
              filled: true,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppAssets.filter),
                    10.w.horizontalSpace,
                    SvgPicture.asset(AppAssets.scan),
                  ],
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
                child: TabBarView(controller: tabController, children: [
              AllProductsTabView(
                query: _query,
              ),
              const CleanserTabView(),
              const TonerTabView(),
              const MoisturiserTabView(),
              const SerumTabView(),
              const SunScreenTabView()
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
  const AllProductsTabView({super.key, this.onTap, required this.query});

  final void Function()? onTap;

  final String query;

  @override
  ConsumerState<AllProductsTabView> createState() => _AllProductsTabViewState();
}

class _AllProductsTabViewState extends ConsumerState<AllProductsTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(loadProductsProvider).when(
          data: (product) => product != null
              ? product.isEmpty
                  ? const Center(
                      child: Text('No products available'),
                    )
                  : ProductsGrid(
                      products: product,
                    )
              : const Center(
                  child: Text('Error occured on loading'),
                ),
          error: (e, s) => Center(
                child: Text('Error Occured: $e'),
              ),
          loading: () => CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
    });

    //   return FutureBuilder(
    //     future: futureProduct,
    //     builder: (context, snapshot) {

    //       final products = snapshot.data;
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //             child: CircularProgressIndicator(
    //           color: Theme.of(context).primaryColor,
    //         ));
    //       } else if (snapshot.hasError) {
    //         return Center(child: Text('Error: ${snapshot.error}'));
    //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //         return const Center(child: Text('No products added.'));
    //       }
    //       return ProductsGrid(products: products!);
    //     },
    //   );
    // }
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.77,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
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
              if (product.image != null && product.image!.isNotEmpty)
                Image.file(
                  File(product.image!),
                  height: 160,
                  width: 155,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported,
                      size: 50,
                    );
                  },
                )
              else
                const Icon(
                  Icons.image_not_supported,
                  size: 200,
                ),
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

class CleanserTabView extends ConsumerStatefulWidget {
  const CleanserTabView({super.key});

  @override
  ConsumerState<CleanserTabView> createState() => _CleanserTabViewState();
}

class _CleanserTabViewState extends ConsumerState<CleanserTabView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(loadProductsProvider).when(
          data: (product) => product != null
              ? product.isEmpty
                  ? const Center(
                      child: Text('No products available'),
                    )
                  : ProductsGrid(
                      products: product
                          .where((product) => product.productType == 'Cleanser')
                          .toList(),
                    )
              : const Center(
                  child: Text('Error on loading products available'),
                ),
          error: (e, s) => Center(
                child: Text('Error Occured: $e'),
              ),
          loading: () => CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
    });
  }
}

class TonerTabView extends StatelessWidget {
  const TonerTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(loadProductsProvider).when(
          data: (product) => product != null
              ? product.isEmpty
                  ? const Center(
                      child: Text('No products available'),
                    )
                  : ProductsGrid(
                      products: product
                          .where((product) => product.productType == 'Toner')
                          .toList(),
                    )
              : const Center(
                  child: Text('Error on loading products available'),
                ),
          error: (e, s) => Center(
                child: Text('Error Occured: $e'),
              ),
          loading: () => CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
    });
  }
}

class MoisturiserTabView extends StatelessWidget {
  const MoisturiserTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(loadProductsProvider).when(
          data: (product) => product != null
              ? product.isEmpty
                  ? const Center(
                      child: Text('No products available'),
                    )
                  : ProductsGrid(
                      products: product
                          .where(
                              (product) => product.productType == 'Moisturiser')
                          .toList(),
                    )
              : const Center(
                  child: Text('Error on loading products available'),
                ),
          error: (e, s) => Center(
                child: Text('Error Occured: $e'),
              ),
          loading: () => CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
    });
  }
}

class SerumTabView extends StatelessWidget {
  const SerumTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(loadProductsProvider).when(
          data: (product) => product != null
              ? product.isEmpty
                  ? const Center(
                      child: Text('No products available'),
                    )
                  : ProductsGrid(
                      products: product
                          .where((product) => product.productType == 'Serum')
                          .toList(),
                    )
              : const Center(
                  child: Text('Error on loading products available'),
                ),
          error: (e, s) => Center(
                child: Text('Error Occured: $e'),
              ),
          loading: () => CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
    });
  }
}

class SunScreenTabView extends StatelessWidget {
  const SunScreenTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(loadProductsProvider).when(
          data: (product) => product != null
              ? product.isEmpty
                  ? const Center(
                      child: Text('No products available'),
                    )
                  : ProductsGrid(
                      products: product
                          .where(
                              (product) => product.productType == 'Sunscreen')
                          .toList(),
                    )
              : const Center(
                  child: Text('Error on loading products available'),
                ),
          error: (e, s) => Center(
                child: Text('Error Occured: $e'),
              ),
          loading: () => CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
    });
  }
}
