import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/config/route/app_routes.dart';
import 'package:umodzi/features/home/controller/home_controller.dart';

import '../../../component/common_appbar/common_appbar.dart';
import '../../../component/text/common_text.dart';
import '../widget/event_card.dart';
import '../../../component/other_widgets/common_skeleton.dart';

class AllActiveEventScreen extends StatefulWidget {
  const AllActiveEventScreen({super.key});

  @override
  State<AllActiveEventScreen> createState() => _AllActiveEventScreenState();
}

class _AllActiveEventScreenState extends State<AllActiveEventScreen> {
  final HomeController controller = Get.find<HomeController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch first page after the build is complete to avoid "setState() called during build" error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAllActiveEvents();
    });
    
    // Setup pagination listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        controller.fetchAllActiveEvents(isLoadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Active Events",
        showBackButton: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(() {
            // Show skeleton only on initial load
            if (controller.isEventsLoading.value && controller.allActiveEvents.isEmpty) {
              return ListView.builder(
                padding: EdgeInsets.only(top: 18.h),
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: CommonSkeleton(height: 130.h, width: double.infinity, borderRadius: 16),
                ),
              );
            }

            // Show empty message only if not loading and list is empty
            if (controller.allActiveEvents.isEmpty && !controller.isEventsLoading.value) {
              return const Center(child: CommonText(text: "No active events found"));
            }

            return Column(
              children: [
                SizedBox(height: 18.h),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: controller.allActiveEvents.length + (controller.isMoreLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.allActiveEvents.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final event = controller.allActiveEvents[index];
                      
                      // Calculate days remaining
                      int daysLeft = 0;
                      if (event.eventDeadline != null) {
                        daysLeft = event.eventDeadline!.difference(DateTime.now()).inDays;
                      }

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.eventDetailsScreen, arguments: {
                            'eventId': event.id,
                            'hasPenalty': false,
                            'category': event.eventType,
                            'minContribution': event.minContribution,
                            'daysRemaining': daysLeft < 0 ? 0 : daysLeft,
                          });
                        },
                        child: EventCard(
                          title: event.name ?? "",
                          amount: '\$ ${event.minContribution?.toStringAsFixed(2)}',
                          category: event.eventType ?? "",
                          timeLeft: event.eventDeadline != null 
                              ? '${daysLeft < 0 ? 0 : daysLeft} days left' 
                              : "",
                          imagePath: event.banner ?? "",
                          isUrgent: daysLeft <= 7 && daysLeft >= 0,
                          actionText: daysLeft <= 7 && daysLeft >= 0 ? 'Urgent' : '',
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
