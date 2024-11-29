import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as dio;
import 'package:todo_app_project/core/core/extensions/extensions.dart';
import '../../../../../../main.dart';
import '../../../../core/app_component/app_component.dart';
import '../../../../core/network/configuration.dart';
import '../../../get_all_task/presentation/ui/widgets/custom_toast.dart';
import '../../../widget/custom_elevatedButton/custom_text.dart';
import '../../data/model/profile_model.dart';
import '../../domain/repository/profile_update_repository.dart';
import '../../domain/usecase/profile_update_pass_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class ProfileUpdateController extends GetxController {
  var obscureTextPassword = true.obs;
  var obscureTextConfirmPassword = true.obs;
  var profileModel = ProfileModel().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var addressController = TextEditingController().obs;
  final ImagePicker picker = ImagePicker();
  var pickedImage = File("").obs;
  var isLoading = false.obs;
  final box = GetStorage();
  var isClickable = true.obs;
  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }
  void fetchProfile() async {
      isLoading.value = true;
    try {
      ProfileModelPassUseCase userOrderListPassUseCase =
      ProfileModelPassUseCase(locator<ProfileUpdateRepository>());
      var response = await userOrderListPassUseCase();
      if (response?.data?.data != null) {
        profileModel.value = response?.data ?? ProfileModel();
        insetingData();
        isLoading.value = false;
      }
    } catch (error) {
      isLoading.value = false;
      // isLoading.value = false;
      // Handle errors here, if needed
    }finally{
      isLoading.value = false;
    }

  }
  void insetingData(){
    firstNameController.value.text = profileModel.value.data?.firstName ?? '';
    lastNameController.value.text = profileModel.value.data?.lastName ?? '';
    addressController.value.text = profileModel.value.data?.address ?? '';
    passwordController.value.text = profileModel.value.data?.password ?? '';
  }
  Future<void> submitProfileUpdate(BuildContext context) async {
    try {
      isLoading.value = true;

      // Initialize use case
      final profileUpdatePassUseCase =
      ProfileUpdatePassUseCase(locator<ProfileUpdateRepository>());

      // Prepare file paths
      final photoUrl = "${NetworkConfiguration.baseUrl}${box.read("photo")}";
      final tempDir = await getTemporaryDirectory(); // Get temporary directory
      final tempFilePath = '${tempDir.path}/${profileModel.value.data?.image?.split('/').last}';

      // Download file if no image is picked
      if (pickedImage.value.path.isEmpty) {
        print("Downloading profile image...");
        await dio.Dio().download(photoUrl, tempFilePath);
      }

      // Prepare FormData
      final formData = dio.FormData.fromMap({
        "firstName": firstNameController.value.text,
        "lastName": lastNameController.value.text,
        "address": addressController.value.text,
        "password": passwordController.value.text,
        "file": await _prepareFile(
          pickedImage.value.path,
          tempFilePath,
          profileModel.value.data?.image,
        ),
      });

      // Call API
      final response = await profileUpdatePassUseCase(formData);

      // Handle response
      if (response?.data != null) {
        print("Profile update successful.");
        isClickable.value = true;
        successToast(
          context: context,
          msg: response?.data?.message.toString() ?? 'Profile updated successfully!',
        );
      } else {
        print("No data returned from the API.");
      }
    } catch (e, stacktrace) {
      // Log and handle errors
      print("Error occurred during profile update: $e");
      print("Stacktrace: $stacktrace");
    } finally {
      // Stop loading indicator
      isLoading.value = false;
    }
  }

  Future<dio.MultipartFile> _prepareFile(String pickedImagePath, String tempFilePath, String? serverImagePath) async {
    String filePath;
    String fileName;

    if (pickedImagePath.isNotEmpty) {
      // Use the picked image
      filePath = pickedImagePath;
      fileName = pickedImagePath.split('/').last;
    } else {
      // Use the temporary file path or server image
      filePath = tempFilePath;
      fileName = serverImagePath?.split('/').last ?? 'default.jpg';
    }

    // Ensure the file exists
    if (!await File(filePath).exists()) {
      throw Exception("File does not exist at path: $filePath");
    }

    // Use lookupMimeType to get the MIME type
    final mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';

    // Create and return MultipartFile with contentType
    return dio.MultipartFile.fromFile(
      filePath,
      filename: fileName,
      contentType: MediaType.parse(mimeType), // Correct usage without prefix
    );
  }
  Future<void> pickImageCamera() async {
    // Request camera permission and storage permissions for Android 10 and below
    if (await Permission.camera.request().isGranted &&
        (await Permission.storage.request().isGranted ||
            await Permission.photos.request().isGranted)) {
      // Pick image from camera
      XFile? xFile = await picker.pickImage(source: ImageSource.camera);

      if (xFile != null) {
        pickedImage.value = File(xFile.path);
        Navigator.pop(navigatorKey.currentContext!);
        print("Image picked from camera: ${pickedImage.value}");
        update();
      }
    } else if (await Permission.camera.isPermanentlyDenied ||
        await Permission.storage.isPermanentlyDenied) {
      // If the permission is permanently denied, open the app settings
      await openAppSettings();
    } else if (await Permission.camera.isDenied ||
        await Permission.storage.isDenied) {
      // Request permission if it's denied but not permanently
      await Permission.camera.request();
      await Permission.storage.request();
    }
    update();
  }

  Future<void> pickImageFromGallery() async {
    if (await Permission.storage.request().isGranted ||
        await Permission.photos.request().isGranted) {
      XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        pickedImage.value = File(xFile.path);
        print(pickedImage);
        Navigator.pop(navigatorKey.currentContext!);
        update();
      }
    } else if (await Permission.storage.request().isPermanentlyDenied ||
        await Permission.photos.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied ||
        await Permission.photos.request().isDenied) {
      await Permission.storage.request();
    }
    update();
  }
  void showCustomDialog({
    required BuildContext context,
  }) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomSimpleText(
                  text: "Choose an item to pick image",
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        pickImageFromGallery();
                      },
                      child: Column(
                        mainAxisSize:
                        MainAxisSize.min, // Adjusts height dynamically
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.image,
                              size: 40,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          CustomSimpleText(
                            text: "Gallery",
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
                    40.pw,
                    InkWell(
                      onTap: () {
                       pickImageCamera();
                      },
                      child: Column(
                        mainAxisSize:
                        MainAxisSize.min, // Adjusts height dynamically
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.image,
                              size: 40,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          CustomSimpleText(
                            text: "Camera",
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
