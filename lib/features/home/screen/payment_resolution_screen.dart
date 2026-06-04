import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../component/common_appbar/common_appbar.dart';

class PaymentResolutionScreen extends StatelessWidget {
  const PaymentResolutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSuspended = Get.arguments?['isSuspended'] ?? false;

    return Scaffold(
      appBar: CommonAppBar(
        title: 'Payment Details',
        showBackButton: true,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: 'BREAKDOWN OF DUES',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondaryColor,
                          letterSpacing: 0.5,
                        ),
                        _buildStatusBadge(isSuspended),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    
                    _buildDueCard(),
                    SizedBox(height: 12.h),
                    _buildDueCard(),
                    
                    SizedBox(height: 24.h),
                    
                    _buildSummarySection(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.r),
              child: CommonButton(
                titleText: 'Next',
                buttonColor: AppColors.green,
                buttonRadius: 12,
                titleSize: 16,
                titleWeight: FontWeight.w600,
                onTap: () {


Get.back();
Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isSuspended) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isSuspended ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuspended ? Icons.report_gmailerrorred_rounded : Icons.check_circle_outline,
            color: isSuspended ? const Color(0xFFEF4444) : AppColors.green,
            size: 16.sp,
          ),
          SizedBox(width: 4.w),
          CommonText(
            text: isSuspended ? 'Suspended' : 'Active',
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isSuspended ? const Color(0xFFEF4444) : AppColors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildDueCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Title and Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: 'Support for Banda Family',
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: CommonText(
                  text: 'Member Funeral',
                  fontSize: 10.sp,
                  color: const Color(0xFFF59E0B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          
          // Deadline Info
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 14.sp, color: AppColors.textSecondaryColor),
              SizedBox(width: 6.w),
              CommonText(
                text: 'Deadline Passed:',
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor,
              ),
              const Spacer(),
              CommonText(
                text: 'April 10, 2026',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFFF1F5F9), thickness: 1),
          SizedBox(height: 12.h),
          
          // Contribution and Penalty breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondaryColor),
                      children: [
                        const TextSpan(text: 'Minimum contribution '),
                        TextSpan(
                          text: '\$30.00',
                          style: TextStyle(color: const Color(0xFFD32F2F), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CommonText(text: 'Total Due', fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.black),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondaryColor),
                      children: [
                        const TextSpan(text: 'Penalty fee '),
                        TextSpan(
                          text: '\$5.00',
                          style: TextStyle(color: const Color(0xFFD32F2F), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CommonText(
                    text: '\$ 35.00',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFD32F2F),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8F1), // Light greenish background as per screenshot
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Total Events Dues', '\$70.00'),
          SizedBox(height: 12.h),
          _buildSummaryRow('Penalty Fee (Late Payment)', '\$10.00'),
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFFE2E8F0), thickness: 1),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: 'Total Due',
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              CommonText(
                text: '\$80.00',
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFD32F2F),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: title,
          fontSize: 14.sp,
          color: AppColors.textSecondaryColor,
        ),
        CommonText(
          text: amount,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ],
    );
  }
}
