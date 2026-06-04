import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_icons.dart';

class PayPendingParticipationInfo extends StatelessWidget {
  final double total;

  const PayPendingParticipationInfo({
    super.key,
    required this.total,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
                text: '32 of 45 members paid',
                fontSize: 12,
                color: Color(0xFF64748B)),
            CommonText(text: '71%', fontSize: 12, color: Color(0xFF64748B)),
          ],
        ),
        SizedBox(height: 8.h),
        LinearProgressIndicator(
          value: 0.71,
          backgroundColor: const Color(0xFFF1F5F9),
          color: const Color(0xFF31993B),
          minHeight: 6.h,
          borderRadius: BorderRadius.circular(10.r),
        ),
        SizedBox(height: 16.h),
        _buildRow(AppIcons.manI, 'Organized by:', 'Community Admin'),
        _buildRow(AppIcons.date, 'Created on:', 'April 2, 2026'),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
                text: 'Total Due',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
            CommonText(
                text: '\$ ${total.toStringAsFixed(2)}',
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(String icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(icon, height: 16.h, width: 16.w),
              SizedBox(
                width: 4.w,
              ),
              CommonText(
                text: label,
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          CommonText(text: value, fontSize: 14.sp, fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}
