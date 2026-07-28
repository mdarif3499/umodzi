import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../model/completed_contribution_model.dart';

class CompletedEventCard extends StatelessWidget {
  final CompletedContribution item;

  const CompletedEventCard({
    super.key,
    required this.item,
  });
  @override
  Widget build(BuildContext context) {
    String formattedDate = item.paidAt != null 
        ? "Completed on ${DateFormat('MMM d, yyyy').format(item.paidAt!)}" 
        : "";
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: AppColors.green,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CommonText(
                        text: item.eventName ?? "",
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        color: AppColors.color333333,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              CommonText(
                text: "\$ ${item.amountPaid ?? 0}",
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.color333333,
              ),
            ],
          ),

          SizedBox(height: 4.h),
          CommonText(
            text: item.eventType ?? "",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondaryColor,
          ),

          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonText(
                text: formattedDate,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondaryColor,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: CommonText(
                  text: item.status?.capitalizeFirst ?? "",
                  color: AppColors.green,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
