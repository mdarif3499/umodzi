import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../controller/faq_controller.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FaqController controller = Get.put(FaqController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(
        title: "FAQ's",
        showBackButton: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.faqList.isEmpty) {
          return const Center(child: CommonText(text: "No FAQ's found"));
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          itemCount: controller.faqList.length,
          itemBuilder: (context, index) {
            final faq = controller.faqList[index];
            return FAQItem(
              question: faq.question ?? "",
              answer: faq.answer ?? "",
            );
          },
        );
      }),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          tilePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          title: CommonText(
            text: widget.question,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color333333,
          ),
          trailing: Icon(
            _isExpanded ? Icons.remove : Icons.add,
            size: 20.sp,
            color: _isExpanded ? Colors.black : const Color(0xFF99A1AF),
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: CommonText(
                text: widget.answer,
                fontSize: 12.sp,
                color: AppColors.color6A7282,
                height: 1.6,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
