import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_icons.dart';
import '../model/single_event_model.dart';

class CommunityParticipationCard extends StatelessWidget {
  final bool hasPenalty;
  final double penalty;
  final double minContribution;
  final double totalDue;
  final UserStats? stats;
  final DateTime? createdAt;

  const CommunityParticipationCard({
    super.key,
    required this.hasPenalty,
    required this.penalty,
    required this.minContribution,
    required this.totalDue,
    this.stats,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = stats?.totalPercentage?.toDouble() ?? 0.0;
    String createdOn = createdAt != null ? DateFormat('MMMM d, yyyy').format(createdAt!) : "";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
                text: '${stats?.totalPaidUsers ?? 0} of ${stats?.totalUsers ?? 0} members paid',
                fontSize: 12.sp,
                color: const Color(0xFF64748B)),
            CommonText(text: '${percentage.toInt()}%', fontSize: 12.sp, color: const Color(0xFF64748B)),
          ],
        ),
        SizedBox(height: 8.h),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: const Color(0xFFF1F5F9),
          color: const Color(0xFF31993B),
          minHeight: 6.h,
          borderRadius: BorderRadius.circular(10.r),
        ),
        SizedBox(height: 16.h),
        _buildRow(AppIcons.manI,'Organized by:', 'Community Admin'),
        _buildRow(AppIcons.date,'Created on:', createdOn),

        if (hasPenalty) ...[
          const Divider(height: 24, color: Color(0xFFF1F5F9)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                  text: 'Penalty fee',
                  fontSize: 14.sp,
                  color: const Color(0xFFE11D48)),
              CommonText(
                  text: '\$${penalty.toStringAsFixed(2)}',
                  fontSize: 14.sp,
                  color: const Color(0xFFE11D48)),
            ],
          ),
        ],

        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CommonText(
                text: 'Total Due',
                fontSize: 14,
                fontWeight: FontWeight.w400),
            CommonText(
                text: '\$ ${totalDue.toStringAsFixed(2)}',
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
              SizedBox(width: 4.w),
              CommonText(
                text: label,
                fontSize: 12.sp,
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
