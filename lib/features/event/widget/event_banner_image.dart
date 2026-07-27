import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../component/image/common_image.dart';
import '../../../utils/constants/temp_image.dart';

class EventBannerImage extends StatelessWidget {
  final String? banner;

  const EventBannerImage({super.key, this.banner});

  @override
  Widget build(BuildContext context) {
    return CommonImage(
      imageSrc: banner ?? "",
      height: 240.h,
      width: double.infinity,
      fill: BoxFit.cover,
      defaultImage: TempImage.family,
    );
  }
}
