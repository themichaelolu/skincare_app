import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';
import 'package:skincare_app/src/core/domain/products/provider.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/string_extensions.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';

class AddProductView extends ConsumerStatefulWidget {
  const AddProductView({
    super.key,
    this.product,
  });

  final Product? product;

  @override
  ConsumerState<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends ConsumerState<AddProductView> {
  final formKey = GlobalKey<FormState>;
  final productNameCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final sizesCtrl = TextEditingController();
  final ingredientsCtrl = TextEditingController();

  List<String> ingredients = [];
  List<String> sizes = [];

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

  @override
  void initState() {
    super.initState();
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
                    Navigator.pop;
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
                   Navigator.pop;
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
  Widget build(BuildContext context) {
    // final product = ref.watch(productProvider);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 29),
        child: ButtonWidget(
          onTap: () {
            final product = Product(
              productBrand: brandCtrl.text,
              productName: productNameCtrl.text,
              image: result?.files.single.path ?? AppAssets.bigPic,
              ingredients: ingredients,
              price: double.parse(priceCtrl.text),
              description: descriptionCtrl.text,
              sizes: sizes,
            );
            ref.read(productProvider.notifier).addProduct(product);
          },
          height: 45.h,
          width: screenSize(context).width,
          color: AppColors.primaryColor,
          child: Center(
            child: Text(
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
        centerTitle: true,
        title: const Text(
          'Add a product',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                labelText: 'Product Name',
                controller: productNameCtrl,
                hintText: 'Product Name',
              ),
              10.h.verticalSpace,
              TextFieldWidget(
                labelText: 'Brand Name',
                controller: brandCtrl,
                hintText: 'Brand Name',
              ),
              10.h.verticalSpace,
              TextFieldWidget(
                labelText: 'Price',
                controller: priceCtrl,
                hintText: 'Price',
              ),
              10.h.verticalSpace,
              TextFieldWidget(
                labelText: 'Description',
                controller: descriptionCtrl,
                hintText: 'Describe your product...',
              ),
              10.h.verticalSpace,
              TextFieldWidget(
                labelText: 'Sizes',
                controller: sizesCtrl,
                hintText: 'Enter sizes(commas will add itself)',
                onSaved: (value) {
                  value = sizesCtrl.text;
                  if (value != null && value.isNotEmpty) {
                    sizes =
                        value.split(',').map((size) => size.trim()).toList();
                  }
                },
              ),
              10.h.verticalSpace,
              TextFieldWidget(
                labelText: 'Ingredients',
                controller: ingredientsCtrl,
                hintText: 'Enter ingredients(commas will add itself)',
                onSaved: (value) {
                  value = ingredientsCtrl.text;
                  if (value != null && value.isNotEmpty) {
                    ingredients =
                        value.split(',').map((size) => size.trim()).toList();
                  }
                },
              ),
              20.h.verticalSpace,
              Text(
                'Upload Picture',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              10.h.verticalSpace,
              DragDropContainer(
                onTap: showOptions,
                file: file,
                onPressed: removeFile,
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class DragDropContainer extends StatelessWidget {
  const DragDropContainer({
    super.key,
    this.onTap,
    this.file,
    this.onPressed,
  });

  final void Function()? onTap;
  final File? file;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105.h,
      width: screenSize(context).width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          border: Border.all(color: AppColors.primaryColor)),
      child: file == null
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 35.h,
                      width: 36.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: Align(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: SvgPicture.asset(
                          AppAssets.cloudUploadIcon,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: onTap,
                          child: Text(
                            'Click to Upload',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                          ),
                        ),
                        const Text(' or drag and drop'),
                      ],
                    ),
                    const Text('SVG, PNG, JPG or GIF (max. 800x400px)')
                  ],
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    CupertinoIcons.clear_circled,
                    color: Colors.red,
                  ),
                ),
                Center(
                  child: Text(
                    "📁 ${file!.path.getFileNameAndExtension(file!.path)}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
    );
  }
}
