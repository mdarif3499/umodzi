import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../component/common_appbar/common_appbar.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(
        title: "FAQ's",
        showBackButton: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const FAQItem();
        },
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  const FAQItem({super.key});

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
            text: 'How Share Charge works?',
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color333333,
          ),
          trailing: Icon(
            _isExpanded ? Icons.remove : Icons.add,
            size: 20.sp,
            color:_isExpanded ? Colors.black:Color(0xFF99A1AF),
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: CommonText(
                text:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.",
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
