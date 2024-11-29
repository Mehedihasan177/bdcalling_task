import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../../main.dart';
import '../../../../../core/app_component/app_component.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../get_all_task/presentation/ui/widgets/custom_toast.dart';
import '../../../sign_in/presentation/controller/signin_controller.dart';
import '../../domain/repository/reg_repository.dart';
import '../../domain/usecase/reg_pass_usecase.dart';

class SignupController extends GetxController{
  var obscureTextPassword = true.obs;
  var obscureTextConfirmPassword = true.obs;
  var emailController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var addressController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  final ImagePicker picker = ImagePicker();
  var pickedImage = File("").obs;
  var isLoading = false.obs;
  var signinController = Get.put(SigninController());
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }
  submitSignupData(BuildContext context) async {
    if(firstNameController.value.text.isEmpty){
      errorToast(context: context, msg: "Please enter first name");
    }else if(lastNameController.value.text.isEmpty){
      errorToast(context: context, msg: "Please enter last name");
    }else if(emailController.value.text.isEmpty){
      errorToast(context: context, msg: "Please  enter email");
    }else if(addressController.value.text.isEmpty){
      errorToast(context: context, msg: "Please enter address");
    }else if(passwordController.value.text.isEmpty){
      errorToast(context: context, msg: "Please enter password");
    }else if(confirmPasswordController.value.text != passwordController.value.text){
      errorToast(context: context, msg: "Password is not matched with confirmation password");
    } else if(pickedImage.value.path.isEmpty){
      errorToast(context: context, msg: "Please insert an image");
    }else{
      print("pickedImage.value.path ${pickedImage.value.path}");
      try {
        isLoading.value = true;
        RegPassUseCase signUpPassUseCase =
        RegPassUseCase(locator<RegRepository>());
        var formData = dio.FormData.fromMap({
          "firstName": firstNameController.value.text,
          "lastName": lastNameController.value.text,
          "email": emailController.value.text,
          "address": addressController.value.text,
          "password": passwordController.value.text,
          "file": await dio.MultipartFile.fromFile(
            pickedImage.value.path,
            filename: pickedImage.value.path.split('/').last, // Get the file name
          ),
        });
        var data = {
          "firstName": firstNameController.value.text,
          "lastName": lastNameController.value.text,
          "email": emailController.value.text,
          "address": addressController.value.text,
          "password": passwordController.value.text,
          "password_confirmation": confirmPasswordController.value.text,
          "file": await dio.MultipartFile.fromFile(
            pickedImage.value.path,
            filename: pickedImage.value.path.split('/').last, // Get the file name
          ),
        };
        forCheck(formData);
        var response = await signUpPassUseCase(formData);
        if (response?.data != null && response?.data?.status == "Success"){
          print("this is not here");
          successToast(context: context, msg: response?.data?.message ?? '');
          box.write("token", response?.data);
          isLoading.value = false;
          box.write("fullName", "${firstNameController.value.text} ${lastNameController.value.text}");
          box.write("email", emailController.value.text);
          box.write("password", passwordController.value.text);
          RouteGenerator.pushNamed(context, Routes.activeUserPage);
          // signinController.submitLoginData(context, from: "reg");
        }else {
          if (!context.mounted) return;
          if (response?.data?.status == null) {
            errorToast(context: context, msg: response?.data?.error ?? '');
          }
        }
      } catch (e) {
        print(e.toString());
      }finally{
        isLoading.value = false;
      }
    }
}
forCheck(dio.FormData formData){}
  Future<void> pickImageCamera() async {
    // Request camera permission and storage permissions for Android 10 and below
    if (await Permission.camera.request().isGranted &&
        (await Permission.storage.request().isGranted || await Permission.photos.request().isGranted)) {

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
    if (await Permission.storage.request().isGranted || await Permission.photos.request().isGranted) {
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


}