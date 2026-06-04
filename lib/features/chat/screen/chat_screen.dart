import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../../../config/api/api_end_point.dart';
import '../controller/chat_controller.dart';
import '../model/message_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: '',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 26.w, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(2.r),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.grey.shade100,
                    child: ClipOval(
                      child: Obx(() {
                        if (controller.adminImage.value.isEmpty) {
                          return Icon(
                            Icons.person,
                            size: 24.r,
                            color: Colors.grey.shade400,
                          );
                        }
                        
                        return Image.network(
                          "${ApiEndPoint.imageUrl}${controller.adminImage.value}",
                          fit: BoxFit.cover,
                          width: 40.r,
                          height: 40.r,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 24.r,
                              color: Colors.grey.shade400,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: SizedBox(
                                width: 20.r,
                                height: 20.r,
                                child: const CircularProgressIndicator(strokeWidth: 2),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Obx(() => CommonText(
                  text: controller.adminName.value,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.messages.isEmpty) {
                return const Center(child: CommonText(text: "No messages yet"));
              }
              return ListView.builder(
                reverse: true,
                controller: controller.scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return _buildMessageBubble(message);
                },
              );
            }),
          ),
          _buildMessageInput(controller),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 0.75.sw,
            ),
            padding: EdgeInsets.all(12.sp),
            margin: EdgeInsets.only(bottom: 4.h),
            decoration: BoxDecoration(
              color: message.isMe ? AppColors.green : const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomLeft: Radius.circular(message.isMe ? 16.r : 4.r),
                bottomRight: Radius.circular(message.isMe ? 4.r : 16.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.images != null && message.images!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: message.text.isNotEmpty ? 8.h : 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        "${ApiEndPoint.imageUrl}${message.images![0]}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                if (message.text.isNotEmpty)
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: message.isMe ? Colors.white : AppColors.color333333,
                      height: 1.4,
                    ),
                  ),
              ],
            ),
          ),
          if (message.time.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h, left: 4.w, right: 4.w),
              child: CommonText(
                text: message.time,
                fontSize: 10.sp,
                color: Colors.grey.shade500,
              ),
            )
          else
            SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildMessageInput(ChatController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Obx(() => controller.selectedImages.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    height: 80.h,
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8.w),
                              width: 80.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                image: DecorationImage(
                                  image: FileImage(controller.selectedImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 8.w,
                              child: GestureDetector(
                                onTap: () => controller.removeImage(index),
                                child: Container(
                                  padding: EdgeInsets.all(2.r),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.close, color: Colors.white, size: 14.sp),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )),
            Row(
              children: [
                GestureDetector(
                  onTap: controller.pickImages,
                  child: Icon(Icons.image_outlined, color: Colors.grey.shade600, size: 28.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: controller.messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type here your message',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: controller.sendMessage,
                  child: Obx(() => controller.isSending.value
                      ? const SizedBox(
                          height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: const CommonText(
                            text: 'Send',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
