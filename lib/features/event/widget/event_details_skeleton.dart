import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../component/other_widgets/common_skeleton.dart';

class EventDetailsSkeleton extends StatelessWidget {
  const EventDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
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
}
