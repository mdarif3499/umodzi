import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../component/text/common_text.dart';
import '../../../utils/constants/temp_image.dart';
import '../widget/pay_pending_beneficiary_info.dart';
import '../widget/pay_pending_info_box.dart';
import '../widget/pay_pending_section_card.dart';

class PaymentHistoryDetailsScreen extends StatelessWidget {
  const PaymentHistoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: const Color(0xFFF2E7E4),
                    child: Icon(Icons.arrow_back_ios_new,
                        color: const Color(0xFFA53200), size: 16.sp),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: CommonText(
                      text: ' Details',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 40.w),
              ],
            ),
            SizedBox(height: 30.h),

            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(TempImage.family, height: 60.h, width: 60.w, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonText(
                            text: 'Support for Banda Family',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: const CommonText(
                              text: 'Member Funeral',
                              fontSize: 10,
                              color: Color(0xFFE29D19),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  const CommonText(
                    text: 'Our fellow member\'s family is going through a difficult time. We are coming together to provide support during this period of mourning.',
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                  SizedBox(height: 16.h),

                  Row(
                    children: [
                      const Expanded(
                        child: PayPendingInfoBox(
                            icon: Icons.attach_money,
                            label: 'Min Contribution',
                            value: '\$ 30.00'),
                      ),
                      SizedBox(width: 10.w),
                      const Expanded(
                        child: PayPendingInfoBox(
                            icon: Icons.calendar_month,
                            label: 'Deadline',
                            value: 'April 20, 2026'),
                      ),
                    ],
                  ),

                  const Divider(height: 32, color: Color(0xFFF1F5F9)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText(text: 'Total Paid Amount', fontSize: 14, color: Color(0xFF64748B)),
                      const CommonText(
                        text: '\$ 100.00',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF22C55E),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            const PayPendingSectionCard(
              title: 'Beneficiary Details',
              content: PayPendingBeneficiaryInfo(),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}