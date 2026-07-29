import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../component/text/common_text.dart';
import '../controller/event_details_controller.dart';
import '../widget/beneficiary_info_card.dart';
import '../widget/community_participation_card.dart';
import '../widget/event_banner_image.dart';
import '../widget/event_details_skeleton.dart';
import '../widget/event_info_box.dart';
import '../widget/event_section_card.dart';

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
          return const EventDetailsSkeleton();
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
                  EventBannerImage(banner: event?.banner),
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
                              EventInfoBox(
                                  icon: Icons.attach_money,
                                  label: 'Min Contribution',
                                  value: '\$ ${minContribution.toStringAsFixed(2)}'),
                              SizedBox(width: 7.w),
                              EventInfoBox(
                                  icon: Icons.calendar_month, 
                                  label: 'Deadline',
                                  value: formattedDeadline),
                            ],
                          ),

                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 45.h,
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

              EventSectionCard(
                title: 'Beneficiary Details', 
                content: BeneficiaryInfoCard(beneficiary: beneficiary),
              ),

              SizedBox(height: 20.h),

              // --- Participation Card ---
              EventSectionCard(
                  title: 'Community Participation',
                  content: CommunityParticipationCard(
                      hasPenalty: hasPenalty, 
                      penalty: 5.0, 
                      minContribution: minContribution, 
                      totalDue: totalDue, 
                      stats: stats, 
                      createdAt: event?.createdAt),
              ),

              SizedBox(height: 24.h),

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
}
