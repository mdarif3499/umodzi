import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';

class EventInfoBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const EventInfoBox({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14.sp, color: const Color(0xFF94A3B8)),
                SizedBox(width: 4.w),
                CommonText(
                  text: label,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondaryColor,
                )
              ],
            ),
            SizedBox(height: 6.h),
            CommonText(
              text: value,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.color333333,
            ),
          ],
        ),
      ),
    );
  }
}
