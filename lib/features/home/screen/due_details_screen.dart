import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_icons.dart';
import '../../../component/common_appbar/common_appbar.dart';

class DueDetailsScreen extends StatelessWidget {
  const DueDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Due Details',
        showBackButton: true,
      ),
      backgroundColor: AppColors.background,
      body: ListView.builder(
        padding: EdgeInsets.all(20.sp),
        itemCount: 2,
        itemBuilder: (context, index) {
          return _buildDueCard();
        },
      ),
    );
  }

  Widget _buildDueCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF2F2F2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: CommonText(
                  text: 'Support for Banda Family',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Color(0x26E29D19),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CommonText(
                  text: 'Member Funeral',
                  fontSize: 12,
                  color: Color(0xFFE29D19),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          _buildInfoRow(AppIcons.manI, 'Organized by:', 'Community Admin'),
          SizedBox(height: 8.h),
          _buildInfoRow(AppIcons.date, 'Deadline Passed:', 'April 10, 2026'),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: const Divider(height: 1, color: Color(0xFFF0F0F0)),
          ),

          _buildPriceRow('Minimum contribution', '\$30.00',
              color: Colors.red.shade400),
          SizedBox(height: 8.h),
          _buildPriceRow('Penalty fee', '\$5.00', color: Colors.red.shade400),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: const Divider(height: 1, color: Color(0xFFF0F0F0)),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                text: 'Total Due',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.color333333,
              ),
              CommonText(
                text: '\$ 35.00',
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE43730),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String icon, String label, String value) {
    return Row(
      children: [
        Image.asset(icon, height: 16.sp, width: 16.sp),
        SizedBox(width: 4.w),
        CommonText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondaryColor,
        ),
        const Spacer(),
        CommonText(
          text: value,
          fontSize: 14,
          color: AppColors.color333333,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: color ?? AppColors.textSecondaryColor,
        ),
        CommonText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: color ?? AppColors.color333333,
        ),
      ],
    );
  }
}
