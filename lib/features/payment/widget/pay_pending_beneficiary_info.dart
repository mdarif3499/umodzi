import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_icons.dart';
import '../../../utils/constants/temp_image.dart';

class PayPendingBeneficiaryInfo extends StatelessWidget {
  const PayPendingBeneficiaryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            radius: 25.r, backgroundImage: const AssetImage(TempImage.doctor)),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                children: [
                  CommonText(
                      text: 'John Banda',
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  SizedBox(width: 6.w),
                  CommonText(
                      text: 'Member', fontSize: 12, color: Color(0xFFE29D19)),],
              ),

              ///  ╚══════════════════════════════════════════6a64908f4eba3528f95f1130//6a643e05da7a187d37bed04f\\6a4b512b56072bd52e39681a════════════════════════════════════════════════╝

              Row(
                children: [
                  Image.asset(
                    AppIcons.check3,
                    height: 14.h,
                    width: 15.w,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  const CommonText(
                      text: 'Verified Beneficiary',
                      fontSize: 12,
                      color: Color(0xFFA53200)),
                ],
              ),
              const CommonText(
                  text: 'john.banda@email.com',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color333333),
              const CommonText(
                  text: '+265 999 123 456',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color333333),
              SizedBox(height: 6.h),
              const CommonText(
                  text: 'Lilongwe, Malawi',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color333333),
              SizedBox(height: 6.h),
              Row(
                children: [
                  const Icon(Icons.picture_as_pdf, color: Colors.red, size: 14),
                  SizedBox(width: 4.w),
                  CommonText(
                      text: 'NID.pdf',
                      fontSize: 12.sp,
                      color: AppColors.color333333),
                ],
              ),

              /// 🔔 Notification Service Initialized Request HomeController setOnBackInvokedCallbackInfo Activity$$ExternalSyntheticLambda0@df462b6
              SizedBox(height: 8.h),
              const CommonText(
                  text:
                      'This fund is being raised to support funeral expenses and assist the family during this difficult time.',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color333333),



            ],
          ),
        )
      ],
    );
  }
}
