import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/features/explore/add_product.dart';
import 'package:skincare_app/src/features/home/product_list_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryIconTheme.color,
            )),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(
              Icons.add,
              color: AppColors.primaryColor,
            ),
            title: const Text('Add a product'),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                return const AddProductView();
              }));
            },
          ),
          ListTile(
              leading: const Icon(
                Icons.list,
                color: AppColors.primaryColor,
              ),
              title: const Text('Your list of products'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (context) {
                  return const ProductListView();
                }));
              })
        ],
      ),
    );
  }
}
