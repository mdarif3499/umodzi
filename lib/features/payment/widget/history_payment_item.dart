import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_icons.dart';
import '../model/transaction_model.dart';

class HistoryPaymentItem extends StatelessWidget {
  final TransactionData history;
  final bool showDivider;

  const HistoryPaymentItem({
    super.key,
    required this.history,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = history.createdAt != null 
        ? DateFormat('MMM d').format(history.createdAt!) 
        : "";

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.sp),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.sp),
                decoration: const BoxDecoration(
                    color: Color(0xFFF0FDF4), shape: BoxShape.circle),
                child: Image.asset(AppIcons.checkH,
                    height: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                        text: history.eventId?.name ?? history.note ?? "Payment",
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    SizedBox(height: 2.h),
                    CommonText(
                        text: formattedDate,
                        fontSize: 12,
                        color: AppColors.textSecondaryColor),
                  ],
                ),
              ),
              CommonText(
                  text: "\$ ${history.amount?.toStringAsFixed(2) ?? "0.00"}",
                  fontSize: 16, fontWeight: FontWeight.w400),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1, color: Color(0xFFF1F5F9)),
      ],
    );
  }
}
