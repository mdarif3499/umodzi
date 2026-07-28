import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';

class PendingDuesCard extends StatelessWidget {
  final String amount;
  final String dueDays;
  final VoidCallback onResolveTap;

  const PendingDuesCard({
    super.key,
    required this.amount,
    required this.dueDays,
    required this.onResolveTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: 'PENDING DUES',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color:  Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white, size: 14.sp),
                    SizedBox(width: 4.w),
                    CommonText(text:
                      'Due in $dueDays days',
                    fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: AppColors.white,

                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            amount,
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onResolveTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0x33FFFFFF),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: CommonText(text:
                'Resolve Now',

                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,

              ),
            ),
          ),
        ],
      ),
    );
  }
}
