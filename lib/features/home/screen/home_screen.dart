import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_icons.dart';
import 'package:umodzi/utils/constants/app_images.dart';
import '../../../config/route/app_routes.dart';
import '../controller/home_controller.dart';
import '../widget/custom_home_appbar.dart';
import '../widget/event_card.dart';
import '../widget/payment_tile.dart';
import '../widget/status_card.dart';
import '../../../component/other_widgets/common_skeleton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 270.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.homeImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.2),
                              Colors.black.withValues(alpha: 0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 55,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        bottom: false,
                        child: const CustomHomeAppBar(
                          isTransparent: true,
                          showAddDependent: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 205.h),
                          CommonText(
                            text: 'Welcome back, Marcus',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                          SizedBox(height: 4.h),
                          CommonText(
                            text: "We're here to support you and your community.",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Obx(() {
                        if (controller.isWalletLoading.value) {
                          return CommonSkeleton(height: 180.h, width: double.infinity, borderRadius: 16);
                        }

                        final wallet = controller.walletSummary.value;
                        final isSuspended = wallet.status != 'active';

                        String dueDateStr = "N/A";
                        if (wallet.nextDueDate != null) {
                          dueDateStr = DateFormat('MMM d, yyyy').format(wallet.nextDueDate!);
                        }

                        String lastPaymentDateStr = "N/A";
                        if (wallet.lastPayment?.date != null) {
                          lastPaymentDateStr = DateFormat('MMM d, yyyy').format(wallet.lastPayment!.date!);
                        }

                        return StatusCard(
                          isSuspended: isSuspended,
                          amount: '\$${wallet.pendingAmount?.abs().toStringAsFixed(2) ?? '0.00'}' ,
                          dueDate: dueDateStr,
                          reason: wallet.suspensionInfo?.reason,
                          reactivation: wallet.suspensionInfo?.reactivation,
                          lastPaymentAmount: '\$${wallet.lastPayment?.amount?.toStringAsFixed(2) ?? '0.00'}',
                          lastPaymentDate: lastPaymentDateStr,
                          activeWarning: wallet.activeWarning,
                          onPaymentTap: () {
                            Get.toNamed(AppRoutes.paymentResolution,
                                arguments: {'isSuspended': isSuspended});
                          },
                        );
                      }),
                      SizedBox(height: 24.h),
                      const CommonText(
                        text: 'Quick Actions',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              if (controller.isWalletLoading.value) {
                                return CommonSkeleton(height: 70.h, width: double.infinity, borderRadius: 12);
                              }
                              return _buildQuickAction(
                                height: 30,
                                width: 30,
                                textColor: controller.unreadMessageCount.value > 0 
                                    ? AppColors.green 
                                    : AppColors.textSecondaryColor,
                                icon: AppIcons.messageChat,
                                title: 'Communicate',
                                subtitle: '${controller.unreadMessageCount.value} unread',
                                color: const Color(0xFFE8F5E9),
                                iconColor: AppColors.green,
                                onTap: controller.createChatAndNavigate,
                                badgeCount: controller.unreadMessageCount.value,
                              );
                            }),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Obx(() {
                              if (controller.isWalletLoading.value) {
                                return CommonSkeleton(height: 70.h, width: double.infinity, borderRadius: 12);
                              }
                              return _buildQuickAction(
                                height: 30,
                                width: 30,
                                textColor: const Color(0xFF7039AC),
                                icon: AppIcons.purolee,
                                title: 'My Family',
                                subtitle: '${controller.quickActionData.value.dependenceCount ?? 0} members',
                                color: const Color(0xFFF3E5F5),
                                iconColor: Colors.purple,
                                onTap: () => Get.toNamed(AppRoutes.myFamilyScreen),
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickAction(
                              height: 20,
                              width: 20,
                              textColor: const Color(0xFFA53200).withValues(alpha: 0.6),
                              icon: AppIcons.speaker,
                              title: 'Report Event',
                              subtitle: 'Notify urgent',
                              color: const Color(0xFFFFF7F5),
                              iconColor: const Color(0xFFA53200),
                              onTap: () => Get.toNamed(AppRoutes.reportEvent),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Obx(() {
                              if (controller.isWalletLoading.value) {
                                return CommonSkeleton(height: 70.h, width: double.infinity, borderRadius: 12);
                              }
                              return _buildQuickAction(
                                height: 30,
                                width: 30,
                                textColor: AppColors.textSecondaryColor,
                                icon: AppIcons.payment,
                                title: 'Payments',
                                subtitle: '${controller.quickActionData.value.transactionCount ?? 0} history',
                                color: const Color(0xFFF1F5F9),
                                iconColor: Colors.blueGrey,
                                onTap: () => Get.toNamed(AppRoutes.paymentHistory),
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonText(
                            text: 'Active Events',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          _buildViewAll(() {
                            Get.toNamed(AppRoutes.allActiveEventScreen);
                          }),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Obx(() {
                        if (controller.isEventsLoading.value) {
                          return SizedBox(
                            height: 130.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: CommonSkeleton(height: 130.h, width: 320.w, borderRadius: 16),
                              ),
                            ),
                          );
                        }
                        if (controller.activeEvents.isEmpty) {
                          return SizedBox(
                            height: 130.h,
                            child: const Center(child: CommonText(text: "No active events found")),
                          );
                        }
                        
                        final displayEvents = controller.activeEvents.take(5).toList();
                        
                        return SizedBox(
                          height: 130.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: displayEvents.length,
                            itemBuilder: (context, index) {
                              final event = displayEvents[index];
                              
                              int daysLeft = 0;
                              if (event.eventDeadline != null) {
                                daysLeft = event.eventDeadline!.difference(DateTime.now()).inDays;
                              }

                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.eventDetailsScreen,
                                      arguments: {
                                        'eventId': event.id,
                                        'hasPenalty': false,
                                        'category': event.eventType,
                                        'minContribution': event.minContribution,
                                        'daysRemaining': daysLeft < 0 ? 0 : daysLeft,
                                      });
                                },
                                child: Container(
                                  width: 320.w,
                                  margin: EdgeInsets.only(right: 12.w),
                                  child: EventCard(
                                    title: event.name ?? "",
                                    amount: '\$ ${event.minContribution?.toStringAsFixed(2)}',
                                    category: event.eventType ?? "",
                                    timeLeft: event.eventDeadline != null 
                                        ? '${daysLeft < 0 ? 0 : daysLeft} days left' 
                                        : "",
                                    imagePath: event.banner ?? "",
                                    actionText: daysLeft <= 7 && daysLeft >= 0 ? 'Urgent' : '',
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonText(
                            text: 'Recent Payments',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          _buildViewAll(() {
                            Get.toNamed(AppRoutes.paymentHistory);
                          }),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Obx(() {
                        if (controller.isTransactionsLoading.value) {
                          return Column(
                            children: List.generate(3, (index) => Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: CommonSkeleton(height: 70.h, width: double.infinity, borderRadius: 16),
                            )),
                          );
                        }
                        
                        if (controller.recentTransactions.isEmpty) {
                          return Container(
                            padding: EdgeInsets.all(20.r),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: const Color(0xFFF1F5F9)),
                            ),
                            child: const Center(
                              child: CommonText(text: "No recent payments found"),
                            ),
                          );
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.recentTransactions.length,
                            itemBuilder: (context, index) {
                              final transaction = controller.recentTransactions[index];

                              String dateStr = "";
                              if (transaction.createdAt != null) {
                                dateStr = DateFormat('MMM d').format(transaction.createdAt!);
                              }

                              return PaymentTile(
                                image: AppIcons.checkH,
                                title: transaction.eventId?.name ?? "N/A",
                                date: dateStr,
                                amount: '\$ ${transaction.amount?.toStringAsFixed(2)}',
                                showDivider: index < controller.recentTransactions.length - 1,
                              );
                            },
                          ),
                        );
                      }),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewAll(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CommonText(
            text: 'View all',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.green,
          ),
          SizedBox(width: 4.w),
          Icon(Icons.arrow_forward, color: AppColors.green, size: 16.sp),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required String icon,
    required double height,
    required double width,
    required String title,
    required String subtitle,
    required Color color,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
    bool isFullWidth = false,
    int badgeCount = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: Row(
              children: [
                Image.asset(icon, height: height.h, width: width.w, color: iconColor),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                          text: title,
                          fontSize: 14.sp,
                          color: AppColors.text121212,
                          fontWeight: FontWeight.w600,
                          maxLines: 1),
                      CommonText(
                          text: subtitle,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                          maxLines: 1),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey, size: 20.sp),
              ],
            ),
          ),
          if (badgeCount > 0)
            Positioned(
              top: -5.h,
              right: -5.w,
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount > 9 ? '9+' : '$badgeCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
