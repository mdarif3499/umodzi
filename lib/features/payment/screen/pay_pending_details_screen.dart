import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../component/text/common_text.dart';
import '../../../config/route/app_routes.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/temp_image.dart';
import '../../event/widget/show_success_dialog.dart';
import '../widget/pay_pending_beneficiary_info.dart';
import '../widget/pay_pending_info_box.dart';
import '../widget/pay_pending_participation_info.dart';
import '../widget/pay_pending_section_card.dart';

class PayPendingDetailsScreen extends StatelessWidget {
  const PayPendingDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  TempImage.family,
                  height: 240.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 45.h,
                  left: 20.w,
                  right: 20.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.black.withValues(alpha: 0.3),
                          child: Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 16.sp),
                        ),
                      ),
                      CommonText(
                        text: 'Event Details',
                        color: AppColors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 40.w),
                    ],
                  ),
                ),
                Positioned(
                  top: 180.h,
                  left: 0,
                  right: 0,
                  child: Container(
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
                  ),
                ),
                Positioned(
                  bottom: 25.h,
                  left: 0,
                  right: 0,
                  child: Center(
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
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          CommonText(
                            text: '\$ 150,000',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 260.h),
            SizedBox(height: 20.h),
            const PayPendingSectionCard(
              title: 'Beneficiary Details',
              content: PayPendingBeneficiaryInfo(),
            ),
            SizedBox(height: 20.h),
            const PayPendingSectionCard(
                title: 'Community Participation',
                content: PayPendingParticipationInfo(total: 30.00)),
            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    showSuccessDialog(context);

                    Future.delayed(const Duration(seconds: 2), () {
                      if (Get.isDialogOpen ?? false) {
                        Get.back();
                      }
                      Get.offAllNamed(AppRoutes.navBarScreen);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: CommonText(
                    text: 'Pay Now - \$30}',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
