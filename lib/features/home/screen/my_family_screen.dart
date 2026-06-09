import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../config/api/api_end_point.dart';
import '../../../config/route/app_routes.dart';
import '../controller/family_member_controller.dart';
import '../../../component/other_widgets/common_skeleton.dart';

class MyFamilyScreen extends StatelessWidget {
  const MyFamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FamilyMemberController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
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
                        text: 'My Family',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            
            // Add Dependent Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.addDependentScreen),
                  icon: Icon(Icons.person_add_outlined, size: 16.sp, color: AppColors.green),
                  label: const CommonText(
                    text: 'Add Dependent',
                    fontSize: 13,
                    color: AppColors.green,
                    fontWeight: FontWeight.w500,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Family Members List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: CommonSkeleton(height: 90.h, width: double.infinity, borderRadius: 16),
                    ),
                  );
                }
                
                if (controller.familyMembers.isEmpty) {
                  return const Center(child: CommonText(text: "No family members found", color: Colors.grey));
                }

                return RefreshIndicator(
                  color: AppColors.green,
                  onRefresh: () => controller.getDependents(),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    itemCount: controller.familyMembers.length,
                    itemBuilder: (context, index) {
                      final member = controller.familyMembers[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: const Color(0xFFF1F5F9)),
                        ),
                        child: Row(
                          children: [
                            // Member Avatar with Verification Badge
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 28.r,
                                  backgroundColor: const Color(0xFFF8FAFC),
                                  backgroundImage: member.image != null 
                                      ? CachedNetworkImageProvider(ApiEndPoint.imageUrl + member.image!)
                                      : null,
                                  child: member.image == null 
                                      ? Icon(Icons.person, color: Colors.grey.shade400, size: 32.sp)
                                      : null,
                                ),
                                if (member.isVerified == true)
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(2.r),
                                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                      child: Icon(Icons.verified, color: Colors.blue, size: 14.sp),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(width: 16.w),
                            
                            // Info Section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: CommonText(
                                          text: member.name,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      // Status Chip
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: member.status == 'pending' 
                                              ? Colors.orange.withOpacity(0.1) 
                                              : Colors.green.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20.r),
                                        ),
                                        child: CommonText(
                                          text: member.status?.capitalizeFirst ?? 'Pending',
                                          fontSize: 9.sp,
                                          color: member.status == 'pending' ? Colors.orange : Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  CommonText(
                                    text: "${member.countryCode ?? ''} ${member.phone}",
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                  CommonText(
                                    text: member.relationship,
                                    fontSize: 12.sp,
                                    color: AppColors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            
                            // Edit Button
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20.r),
                                onTap: () => Get.toNamed(AppRoutes.addDependentScreen, arguments: member.id),
                                child: Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.edit_note_rounded, color: AppColors.green, size: 24.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
