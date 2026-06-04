import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String count;
  const SectionHeader({
    super.key,
    required this.title,
    required this.count,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
            text: title,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.color333333),
        CommonText(
            text: count,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondaryColor),
      ],
    );
  }
}
