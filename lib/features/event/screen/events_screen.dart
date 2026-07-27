import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/config/route/app_routes.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../controller/event_controller.dart';
import '../../home/widget/custom_home_appbar.dart';
import '../../home/widget/event_card.dart';
import '../widget/completed_event_card.dart';
import '../../../component/other_widgets/common_skeleton.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key});

  final controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomHomeAppBar(
        hasNotification: true,
        isEventPage: true,
        title: 'Events',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshAll();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonText(
                text: 'View and contribute to active community events.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 24.h),

              // --- Pending Section ---
              const CommonText(
                text: 'Pending Contributions',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              SizedBox(height: 12.h),
              Obx(() {
                if (controller.isPendingLoading.value) {
                  return Column(
                    children: List.generate(2, (index) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: CommonSkeleton(height: 130.h, width: double.infinity, borderRadius: 16),
                    )),
                  );
                }
                if (controller.pendingContributions.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CommonText(text: "No pending contributions found"),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.pendingContributions.length,
                  itemBuilder: (context, index) {
                    final item = controller.pendingContributions[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.eventDetailsScreen, arguments: {
                          'contributionId': item.contributionId,
                          'eventId': item.eventId,
                          'hasPenalty': (item.penaltyApplied ?? 0) > 0,
                          'category': item.eventType,
                          'minContribution': item.amountDue,
                          'daysRemaining': item.daysLeft,
                        });
                      },
                      child: EventCard(
                        title: item.eventName ?? "",
                        amount: "\$ ${item.totalDue ?? 0}",
                        category: item.eventType ?? "",
                        timeLeft: "${item.daysLeft ?? 0} days left",
                        imagePath: item.banner ?? "",
                        isUrgent: item.badge == "Urgent",
                        actionText: item.badge ?? "",
                      ),
                    );
                  },
                );
              }),

              SizedBox(height: 24.h),
              const CommonText(
                text: 'Completed',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              SizedBox(height: 16.h),

              Obx(() {
                if (controller.isLoading.value) {
                  return Column(
                    children: List.generate(3, (index) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: CommonSkeleton(height: 80.h, width: double.infinity, borderRadius: 16),
                    )),
                  );
                }
                if (controller.completedContributions.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CommonText(text: "No completed contributions found"),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.completedContributions.length,
                  itemBuilder: (context, index) {
                    final item = controller.completedContributions[index];
                    return CompletedEventCard(item: item);
                  },
                );
              }),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

