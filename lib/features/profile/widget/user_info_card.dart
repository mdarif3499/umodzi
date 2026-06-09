import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/temp_image.dart';
import '../controller/profile_controller.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../component/other_widgets/common_skeleton.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Row(
          children: [
            CommonSkeleton(height: 80.r, width: 80.r, borderRadius: 40),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonSkeleton(height: 20.h, width: 150.w),
                  SizedBox(height: 8.h),
                  CommonSkeleton(height: 12.h, width: double.infinity),
                  SizedBox(height: 4.h),
                  CommonSkeleton(height: 12.h, width: 180.w),
                  SizedBox(height: 4.h),
                  CommonSkeleton(height: 12.h, width: 200.w),
                ],
              ),
            ),
          ],
        );
      }

      final data = controller.profileData.value;
      if (data == null) {
        return const SizedBox.shrink();
      }

      String getImageUrl(String? path) {
        if (path == null || path.isEmpty) return "";
        if (path.startsWith('http')) return path;
        return "${ApiEndPoint.imageUrl}${path.startsWith('/') ? '' : '/'}$path";
      }

      final imageUrl = getImageUrl(data.image);

      return Row(
        children: [
          Container(
            padding: EdgeInsets.all(3.r),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 80.r,
                      height: 80.r,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 80.r,
                        height: 80.r,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        TempImage.manP,
                        width: 80.r,
                        height: 80.r,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      TempImage.manP,
                      width: 80.r,
                      height: 80.r,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CommonText(
                      text: data.name ?? 'N/A',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.color333333,
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: CommonText(
                        text: data.status?.capitalizeFirst ?? 'Active',
                        color: AppColors.green,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                _buildInfoItem(Icons.mail_outline, data.email ?? 'N/A'),
                _buildInfoItem(Icons.phone_outlined, "${data.countryCode ?? ''} ${data.phone ?? ''}"),
                _buildInfoItem(Icons.location_on_outlined, data.address != null && data.address!.isNotEmpty ? data.address! : 'No address set'),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: const Color(0xFF94A3B8)),
          SizedBox(width: 6.w),
          Expanded(
            child: CommonText(
              text: text,
              fontSize: 12.sp,
              color: AppColors.color333333,
              fontWeight: FontWeight.w400,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
