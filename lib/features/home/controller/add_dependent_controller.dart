import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:umodzi/config/route/app_routes.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../services/api/multipart_helper.dart';
import '../../../utils/app_snackbar.dart';
import 'family_member_controller.dart';

class AddDependentController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final countryCodeController = TextEditingController(text: "+265");
  
  var selectedRelationship = "".obs;
  List<String> relationships = [
    "Father", "Mother", "Spouse", "Wife", "Husband", 
    "Child", "Son", "Daughter", "Sibling", "Brother", "Sister", "Other"
  ];
  
  // For Profile Image
  var selectedImagePath = "".obs;
  var selectedImageName = "".obs;
  
  // For KYC/Document
  var selectedDocPath = "".obs;
  var selectedDocName = "".obs;

  var isEditing = false.obs;
  var isLoading = false.obs;
  String? editingId;
  String initialISOCode = "BD"; 

  @override
  void onInit() {
    super.onInit();
    var argId = Get.arguments;
    if (argId != null && argId is String) {
      isEditing.value = true;
      editingId = argId;
      loadMemberData(argId);
    }
  }

  void loadMemberData(String id) {
    try {
      final familyController = Get.find<FamilyMemberController>();
      final member = familyController.familyMembers.firstWhereOrNull((m) => m.id == id);
      
      if (member != null) {
        nameController.text = member.name;
        phoneController.text = member.phone;
        addressController.text = member.address ?? "";
        countryCodeController.text = member.countryCode ?? "+265";
        selectedRelationship.value = member.relationship;
        
        if (member.countryCode != null) {
          try {
            final country = countries.firstWhere(
              (c) => "+${c.dialCode}" == member.countryCode,
              orElse: () => countries.firstWhere((c) => c.code == "BD"),
            );
            initialISOCode = country.code;
          } catch (e) {
            initialISOCode = "BD";
          }
        }
      }
    } catch (e) {
      debugPrint("Error loading member for edit: $e");
    }
  }

  void onCountryChange(Country country) {
    countryCodeController.text = "+${country.dialCode}";
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        selectedImageName.value = result.files.single.name;
        selectedImagePath.value = result.files.single.path!;
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
      );
      if (result != null && result.files.single.path != null) {
        selectedDocName.value = result.files.single.name;
        selectedDocPath.value = result.files.single.path!;
      }
    } catch (e) {
      debugPrint("Error picking document: $e");
    }
  }

  Future<void> submitMember() async {
    if (nameController.text.isEmpty || phoneController.text.isEmpty || selectedRelationship.value.isEmpty) {
      AppSnackbar.error(title: "Required", message: "Please fill in Name, Phone, and Relationship");
      return;
    }

    try {
      isLoading.value = true;

      String phone = phoneController.text.trim();
      if (phone.startsWith('0')) {
        phone = phone.substring(1);
      }
      
      String countryCode = countryCodeController.text.trim();
      String fullPhoneNumber = "$countryCode$phone";

      Map<String, dynamic> dataMap = {
        "name": nameController.text.trim(),
        "phoneNumber": fullPhoneNumber,
        "countryCode": countryCode,
        "address": addressController.text.trim(),
        "relationship": selectedRelationship.value,
      };

      List<MultipartFileItem> files = [];
      
      if (selectedImagePath.value.isNotEmpty) {
        files.add(MultipartFileItem(filePath: selectedImagePath.value, fileName: 'image'));
      }
      
      if (selectedDocPath.value.isNotEmpty) {
        files.add(MultipartFileItem(filePath: selectedDocPath.value, fileName: 'document'));
      }

      final url = isEditing.value 
          ? ApiEndPoint.updateDependent(editingId!) 
          : ApiEndPoint.createDependent;
      
      final method = isEditing.value ? 'PUT' : 'POST';

      final response = await apiClient.multipart(
        url: url,
        method: method,
        files: files,
        body: {'data': jsonEncode(dataMap)},
      );

      if (response.isSuccess) {
        AppSnackbar.success(
          title: "Success", 
          message: isEditing.value ? "Dependent updated successfully" : "Dependent added successfully"
        );
        Get.find<FamilyMemberController>().getDependents(); // Refresh list

        Get.toNamed(AppRoutes.myFamilyScreen);
      } else {
        AppSnackbar.error(title: "Failed", message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: "Error", message: "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    countryCodeController.dispose();
    super.onClose();
  }
}
