import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../component/image/common_image.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_icons.dart';
import '../../../utils/constants/temp_image.dart';
import '../model/single_event_model.dart';

class BeneficiaryInfoCard extends StatelessWidget {
  final Beneficiary? beneficiary;

  const BeneficiaryInfoCard({super.key, this.beneficiary});

  @override
  Widget build(BuildContext context) {
    final String? image = beneficiary?.image;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonImage(imageSrc: image ?? "", height: 50.r, width: 50.r, borderRadius: 8, fill: BoxFit.cover, defaultImage: TempImage.manP,),
        SizedBox(width: 12.w),
        Expanded(
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  CommonText(text: beneficiary?.name ?? "", fontSize: 14.sp, fontWeight: FontWeight.w400),

                  SizedBox(width: 6.w),
                  CommonText(
                      text: beneficiary?.relationship ?? "",
                      fontSize: 12.sp,
                      color: const Color(0xFFE29D19)),
                ],
              ),

              Row(
                children: [
                  Image.asset(AppIcons.check3, height: 14.h, width: 15.w),
                  SizedBox(width: 4.w),
                  const CommonText(
                      text: 'Verified Beneficiary',
                      fontSize: 12,
                      color: Color(0xFFA53200)),
                ],
              ),

              CommonText(
                  text: beneficiary?.email ?? "",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color333333),

              SizedBox(height: 6.h),

              if (beneficiary?.documents != null && beneficiary!.documents!.isNotEmpty)

                Row(
                  children: [
                    const Icon(Icons.picture_as_pdf, color: Colors.red, size: 14),
                    SizedBox(width: 4.w),
                    CommonText(
                        text: 'Document.pdf',
                        fontSize: 12.sp,
                        color: AppColors.color333333),
                  ],
                ),

              SizedBox(height: 8.h),

              CommonText(
                  text: beneficiary?.fundsReason ?? "",
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color333333
              ),
              CommonText(
                  text: "${beneficiary?.countryCode ?? ""} ${beneficiary?.contactNumber ?? ""}",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color333333),

              SizedBox(height: 6.h),

              CommonText(
                  text: beneficiary?.address ?? "",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color333333),
            ],
          ),
        )
      ],
    );
  }
}
