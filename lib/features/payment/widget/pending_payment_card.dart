import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../component/text/common_text.dart';
import '../model/pending_payment_model.dart';

class PendingPaymentCard extends StatelessWidget {
  final PendingPaymentModel payment;
  final VoidCallback onPayTap;

  const PendingPaymentCard({
    super.key,
    required this.payment,
    required this.onPayTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: CommonText(
                    text: payment.title,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            CommonText(
                text: payment.amount, fontSize: 18, fontWeight: FontWeight.w500)
          ]),
          SizedBox(height: 4.h),
          CommonText(
              text: payment.date,
              fontSize: 12.sp,
              color: AppColors.textSecondaryColor,
              fontWeight: FontWeight.w400),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time,
                      size: 14.sp, color: const Color(0xFF64748B)),
                  SizedBox(width: 4.w),
                  CommonText(
                      text:payment.timeLeft,
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor,
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                width: 100.w,
                height: 38.h,
                child: ElevatedButton(
                  onPressed: onPayTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF31993B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: Size(80.w, 36.h),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text('Pay Now',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold)),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
