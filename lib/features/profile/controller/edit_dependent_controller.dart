import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditDependentController extends GetxController {
  final nameController = TextEditingController(text: 'Tendal Mbeki');
  final phoneController = TextEditingController(text: '01234568775');
  final dobController = TextEditingController(text: '03-12-2000');
  RxString selectedRelationship = 'Brother'.obs;
  RxString selectedFileName = ''.obs;
  RxString selectedImagePath = ''.obs;

  final List<String> relationships = ['Brother', 'Sister', 'Father', 'Mother', 'Spouse', 'Child'];
  RxList<String> uploadedFiles = <String>['NID.pdf', 'NID.pdf'].obs;

  Future<void> selectDate(BuildContext context) async {

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      String formattedDate = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      dobController.text = formattedDate;
    }
  }
  Future<void> pickFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath.value = image.path;
      selectedFileName.value = image.name;
      uploadedFiles.add(image.name);
    }
  }

  void removeFile(int index) {
    uploadedFiles.removeAt(index);
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.onClose();
  }


}