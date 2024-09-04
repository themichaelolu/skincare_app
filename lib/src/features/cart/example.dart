import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text(
              'Pay bills with ease',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            96.h.verticalSpace,
            Container(
              height: 80.h,
              width: screenSize(context).width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xffCDD5DA),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4.0,
                        color: const Color(0xffCDD5DA).withOpacity(0.25),
                        offset: const Offset(0, 4)),
                  ]),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.mobile_screen_share),
                      24.w.horizontalSpace,
                      const Text('Text'),
                    ],
                  )),
            ),
            20.h.verticalSpace,
        
          ],
        ),
      )),
    );
  }
}
