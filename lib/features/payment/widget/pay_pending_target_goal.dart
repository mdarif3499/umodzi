import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';

class PayPendingTargetGoal extends StatelessWidget {
  final String amount;

  const PayPendingTargetGoal({
    super.key,
    required this.amount,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 220.w,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFE29D19),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonText(
              text: 'Target Goal',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.9),
            ),
            CommonText(
              text: amount,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
