import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import 'pay_pending_info_box.dart';

class PayPendingEventInfo extends StatelessWidget {
  const PayPendingEventInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.only(
          left: 16.w, right: 16.sp, bottom: 16.sp, top: 48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonText(
                  text: 'Support for Banda Family',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.color333333,
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: const CommonText(
                    text: 'Member Funeral',
                    fontSize: 10,
                    color: Color(0xFFE29D19),
                  )),
            ],
          ),
          SizedBox(height: 8.h),
          const CommonText(
            text:
                'Our fellow member\'s family is going through a difficult time. We are coming together to provide support during this period of mourning.',
            fontSize: 12,
            color: AppColors.textSecondaryColor,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 20.h),

          // Info Boxes (Min Contribution & Deadline)
          Row(
            children: [
              const PayPendingInfoBox(
                  icon: Icons.attach_money,
                  label: 'Min Contribution',
                  value: '\$ 30'),
              SizedBox(width: 7.w),
              const PayPendingInfoBox(
                  icon: Icons.calendar_month,
                  label: 'Deadline',
                  value: 'April 20, 2026'),
            ],
          ),

          SizedBox(height: 16.h),

          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFFFC9C9)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time,
                        color: const Color(0xFFE11D48),
                        size: 20.sp),
                    SizedBox(width: 8.w),
                    const CommonText(
                      text: 'Only 12 days remaining',
                      color: AppColors.color333333,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                const CommonText(
                  text:
                      'Make your payment within 7 days to skip a \$5 penalty. Missed payments and penalty fee will be added to your due balance.',
                  color: AppColors.textSecondaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
