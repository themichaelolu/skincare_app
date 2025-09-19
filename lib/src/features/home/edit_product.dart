import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skincare_app/src/core/domain/products/prod_controller.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';
import 'package:skincare_app/src/core/domain/products/update_product_ref.dart';

import 'package:skincare_app/src/core/repositories/async_value_ui.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/dropdown.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/explore/add_product.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';

class EditProductView extends ConsumerStatefulWidget {
  const EditProductView({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  ConsumerState<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends ConsumerState<EditProductView> {
  final _formKey = GlobalKey<FormState>();

  final productNameCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final sizesCtrl = TextEditingController();
  final ingredientsCtrl = TextEditingController();
  String? productType;

  List<String> sizes = [];

  List<String> ingredients = [];

  File? file;
  FilePickerResult? result;
  final picker = ImagePicker();

  Future getFileFromFileManager() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'SVG',
        'PNG',
        'JPG',
      ],
    );
    setState(() {
      if (result != null) {
        file = File(result!.files.single.path!);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      }
    });
  }

  removeFile() {
    setState(() {
      file = null;
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    getFileFromFileManager();
                  },
                  child: const Text(
                    'Take from gallery',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Take from camera',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    productNameCtrl.text = widget.product.productName ?? '';
    brandCtrl.text = widget.product.productBrand ?? '';
    priceCtrl.text = widget.product.price.toString();
    descriptionCtrl.text = widget.product.description ?? '';
    file = File(widget.product.image ?? '');

    ingredients = widget.product.ingredients ?? [];
    sizes = widget.product.sizes ?? [];
    productType = widget.product.productType ?? '';
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loadProductsProvider,
        (_, state) => state.showAlertDialogOnError(context));

    final productProv = ref.watch(loadProductsProvider);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 29),
        child: ButtonWidget(
          onTap: () async {
            final updatedProduct = Product(
              id: widget.product.id,
              productName: productNameCtrl.text,
              productBrand: brandCtrl.text,
              price: double.parse(priceCtrl.text),
              description: descriptionCtrl.text,
              image: widget.product.image,
              ingredients: ingredients,
              sizes: sizes,
              productType: productType,
            );

            await ref.read(updateProductProvider.notifier).updateProduct(
              
                product: updatedProduct,
                afterFetched: () => Navigator.of(context).pop());
          },
          height: 45.h,
          width: screenSize(context).width,
          color: AppColors.primaryColor,
          child: Center(
            child: productProv.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Continue',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Edit your product',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      labelText: 'Product Name',
                      controller: productNameCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    10.h.verticalSpace,
                    TextFieldWidget(
                      labelText: 'Product Brand',
                      controller: brandCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    10.h.verticalSpace,
                    TextFieldWidget(
                      labelText: 'Price',
                      controller: priceCtrl,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    10.h.verticalSpace,
                    TextFieldWidget(
                      labelText: 'Description',
                      controller: descriptionCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    10.h.verticalSpace,
                    TextFieldWidget(
                      labelText: 'Sizes',
                      controller: sizesCtrl,
                      onChanged: (value) {
                        setState(() {
                          sizes = sizesCtrl.text.split(',').toList();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    10.h.verticalSpace,
                    TextFieldWidget(
                      labelText: 'Ingredients',
                      controller: ingredientsCtrl,
                      onChanged: (value) {
                        setState(() {
                          ingredients = ingredientsCtrl.text
                              .split(',')
                              .map((e) => e.trim())
                              .toList();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    10.h.verticalSpace,
                    Text(
                      'Product Type',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    5.h.verticalSpace,
                    AppDropdownInput(
                      hintText: productType ?? '',
                      value: productType ?? '',
                      onChanged: (value) {
                        setState(() {
                          productType = value!;
                        });
                      },
                      text: productType ?? '',
                      options: const [
                        'Cleanser',
                        'Toner',
                        'Moisturiser',
                        'Serum',
                        'Sunscreen',
                      ],
                    ),
                    10.h.verticalSpace,
                    Text(
                      'Upload Picture',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    10.h.verticalSpace,
                    DragDropContainer(
                      onTap: showOptions,
                      file: File(widget.product.image!),
                      onPressed: removeFile,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

// extension AppAssetExtension on String {
//   String toAsset() {
//     switch (true) {
//       case true:
//         if (contains('data')) {
//           return AppAssets.appleIcon;
//         } else if (contains('airtime')) {
//           return AppAssets.applePay;
//         }
//         return this;
//       case false:
//         return this;
//     }
//   }
// }
