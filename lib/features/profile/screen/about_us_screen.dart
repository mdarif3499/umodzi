import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/text/common_text.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../controller/about_us_controller.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutUsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: "About Us",
        showBackButton: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.black));
        }
        
        if (controller.aboutUsContent.value.isEmpty) {
          return const Center(child: CommonText(text: "No content available"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Html(
            data: controller.aboutUsContent.value,
            style: {
              "body": Style(
                fontSize: FontSize(14.sp),
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                lineHeight: const LineHeight(1.5),
                padding: HtmlPaddings.zero,
                margin: Margins.zero,
              ),
              "strong": Style(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            },
          ),
        );
      }),
    );
  }
}
