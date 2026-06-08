import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_icons.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/temp_image.dart';
import '../controller/event_details_controller.dart';
import '../../../component/other_widgets/common_skeleton.dart';
import '../../../component/image/common_image.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EventDetailsController());
    final dynamic args = Get.arguments;
    
    final String eventId = args['eventId']?.toString() ?? "";
    final bool hasPenalty = args['hasPenalty'] == true;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (eventId.isNotEmpty) {
        controller.fetchEventDetails(eventId);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildSkeleton();
        }

        final data = controller.eventData.value;
        if (data == null) {
          return const Center(child: CommonText(text: "No details found"));
        }

        final event = data.event;
        final stats = data.users;
        final beneficiary = event?.beneficiary;

        final double minContribution = event?.minContribution ?? 0.0;
        const double penaltyFee = 5.00;
        final double totalDue = hasPenalty ? (minContribution + penaltyFee) : minContribution;

        String formattedDeadline = event?.eventDeadline != null 
            ? DateFormat('MMMM d, yyyy').format(event!.eventDeadline!) 
            : "No deadline";

        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildBannerImage(event?.banner),
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
                          left: 16.w, right: 16.w, bottom: 16.h, top: 48.h),
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
                                  text: event?.name ?? 'Event Name',
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
                                child: CommonText(
                                  text: event?.eventType ?? "",
                                  fontSize: 10.sp,
                                  color: const Color(0xFFE29D19),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          CommonText(
                            text: event?.description ?? "",
                            fontSize: 12.sp,
                            color: AppColors.textSecondaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 20.h),

                          // Info Boxes
                          Row(
                            children: [
                              _buildInfoBox(
                                  Icons.attach_money,
                                  'Min Contribution',
                                  '\$ ${minContribution.toStringAsFixed(2)}'),
                              SizedBox(width: 7.w),
                              _buildInfoBox(Icons.calendar_month, 'Deadline',
                                  formattedDeadline),
                            ],
                          ),

                          SizedBox(height: 16.h),
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
                              text: '\$ ${event?.targetContribution?.toStringAsFixed(0) ?? "0"}',
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

              SizedBox(height: 140.h),

              // --- Beneficiary Details Card ---
              _buildSectionCard('Beneficiary Details', _buildBeneficiaryInfo(beneficiary)),

              SizedBox(height: 20.h),

              // --- Participation Card ---
              _buildSectionCard(
                  'Community Participation',
                  _buildParticipationInfo(
                      hasPenalty, 5.0, minContribution, totalDue, stats, event?.createdAt)),

              SizedBox(height: 24.h),

              // --- Pay Button ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: Obx(() => ElevatedButton(
                    onPressed: controller.isPaymentLoading.value 
                        ? null 
                        : () => controller.createCheckoutSession(eventId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: controller.isPaymentLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : CommonText(
                            text: 'Pay Now - \$${totalDue.toStringAsFixed(2)}',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                  )),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSkeleton() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CommonSkeleton(height: 240.h, width: double.infinity, borderRadius: 0),
              Positioned(
                top: 45.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonSkeleton(height: 40.r, width: 40.r, borderRadius: 20),
                    CommonSkeleton(height: 20.h, width: 120.w),
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
                      left: 16.w, right: 16.w, bottom: 16.h, top: 48.h),
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
                          CommonSkeleton(height: 20.h, width: 150.w),
                          CommonSkeleton(height: 20.h, width: 60.w, borderRadius: 20),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      CommonSkeleton(height: 12.h, width: double.infinity),
                      SizedBox(height: 6.h),
                      CommonSkeleton(height: 12.h, width: 200.w),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(child: CommonSkeleton(height: 60.h, width: double.infinity)),
                          SizedBox(width: 7.w),
                          Expanded(child: CommonSkeleton(height: 60.h, width: double.infinity)),
                        ],
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
                  child: CommonSkeleton(height: 60.h, width: 220.w, borderRadius: 12),
                ),
              ),
            ],
          ),
          SizedBox(height: 140.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CommonSkeleton(height: 150.h, width: double.infinity, borderRadius: 16),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CommonSkeleton(height: 180.h, width: double.infinity, borderRadius: 16),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CommonSkeleton(height: 52.h, width: double.infinity, borderRadius: 10),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildBannerImage(String? banner) {
    return CommonImage(
      imageSrc: banner ?? "",
      height: 240.h,
      width: double.infinity,
      fill: BoxFit.cover,
      defaultImage: TempImage.family,
    );
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color333333,
          ),
          SizedBox(height: 12.h),
          content,
        ],
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14.sp, color: const Color(0xFF94A3B8)),
                SizedBox(width: 4.w),
                CommonText(
                  text: label,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondaryColor,
                )
              ],
            ),
            SizedBox(height: 6.h),
            CommonText(
              text: value,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.color333333,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeneficiaryInfo(dynamic beneficiary) {
    final String? image = beneficiary?.image;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonImage(
          imageSrc: image ?? "",
          height: 50.r,
          width: 50.r,
          borderRadius: 8,
          fill: BoxFit.cover,
          defaultImage: TempImage.manP, // Using manP as default for person
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonText(
                      text: beneficiary?.name ?? "",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
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
                  color: AppColors.color333333),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildParticipationInfo(
      bool hasPenalty, double penalty, double min, double total, dynamic stats, DateTime? createdAt) {
    double percentage = stats?.totalPercentage?.toDouble() ?? 0.0;
    String createdOn = createdAt != null ? DateFormat('MMMM d, yyyy').format(createdAt) : "";

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
                text: '\$ ${total.toStringAsFixed(2)}',
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
