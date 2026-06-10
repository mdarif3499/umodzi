import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_icons.dart';

import '../text/common_text.dart';


class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(
                  AppIcons.arrowAppbar,
                  width: 44.w,
                  height: 44.h,
                ),
              )
            else
              SizedBox(width: 44.w),

            Expanded(
              child: Center(
                child: CommonText(
                  text: title,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF333333),
                ),
              ),
            ),

            if (actions != null)
              Row(children: actions!)
            else
              SizedBox(width: 44.w),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}