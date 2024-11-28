import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app_project/core/core/extensions/extensions.dart';
import '../../../../../../core/routes/route_name.dart';
import '../../../../../../core/routes/router.dart';
import '../../../../../../main.dart';
import '../../../../../core/app_component/app_component.dart';
import '../../../../../core/utils/consts/app_sizes.dart';
import '../../../../todo_details/ui/widgets/custom_toast.dart';
import '../../../../widget/custom_elevatedButton/custom_text.dart';
import '../../data/model/login_model.dart';
import '../../domain/repository/login_repository.dart';
import '../../domain/usecase/login_with_id_pass_usecase.dart';

class SigninController extends GetxController {
  var obscureText = true.obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var passwordVisibility = false.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    print("session data ${box.read("email")} ${box.read("password")}");
    emailController.value.text = box.read("email") ?? "";
    passwordController.value.text = box.read("password") ?? "";
  }

  passwordVisibilityFun() {
    passwordVisibility.value = !passwordVisibility.value;
    print(passwordVisibility.value);
    update();
  }

  errorMessageHandling(String? s) {
    if (passwordController.value.text.isNotEmpty) {
      errorMessage.value = 'Password must be filled';
    } else {
      errorMessage.value = '';
    }
    update();
  }

  submitLoginData(BuildContext context, {required String from}) async {
    try {
      LoginWithIdPassUseCase loginUseCase =
          LoginWithIdPassUseCase(locator<SignInRepository>());
      if (emailController.value.text.isEmpty && (box.read("email")?.isEmpty ?? false)) {
        errorToast(context: context, msg: "Please enter email");
      } else if (passwordController.value.text.isEmpty && (box.read("password")?.isEmpty ?? false)) {
        errorToast(context: context, msg: "Please enter password");
      } else {
        isLoading.value = true;
        update();
        var response = await loginUseCase(
            userName: box.read("email") ?? emailController.value.text,
            password: box.read("password") ?? passwordController.value.text);
        print("this is data of login ${response?.data?.data?.user?.email}");
        if (response?.data != null) {
          box.write("email",response?.data?.data?.user?.email);
          session.createSession(response?.data,
              phoneNumber: emailController.value.text,
              password: passwordController.value.text);

          box.write("fullName", response?.data?.data?.user?.email);
          box.write("amount", response?.data?.data?.user?.email);
          if (from != "profile") {
            RouteGenerator.pushNamedAndRemoveAll(context, Routes.homepage);
          }
          if (!context.mounted) return;
          if ((box.read("email").toString().isEmpty) &&
              (box.read("password").toString().isEmpty)) {
            if (from == "signin") {
              successToast(
                  context: context, msg: response?.data?.message ?? '');
            }
          }
        } else {
          if (!context.mounted) return;
          if (response?.data?.status == null) {
            errorToast(context: context, msg: "Invalid login credential!");
          }
        }
      }
    } catch (e) {
      isLoading.value = false;
      if(e.toString().contains("401")){
        errorToast(context: context, msg: "Invalid login credential!");
      }else{
        ErrorDialog(context,
            msg:
            "Server Error!, Don't be panic. Your all data will be safe.\nPlease contact with number:",
            msg2: "01886372032");
      }
      print("response?.data?.status ${e.toString()}");

      print(e.toString() ?? '');
    } finally {
      isLoading.value = false;
    }
    isLoading.value = false;
    update();
  }

  void ErrorDialog(BuildContext context,
      {required String msg, required String msg2}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less curved corners
          ),
          title: CustomSimpleText(
            text: "Server Error",
            color: Colors.red,
            fontSize: AppSizes.size17,
          ),
          content: SingleChildScrollView(
            // Allows the content to scroll if it exceeds available height
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Ensures dialog adjusts to content height
              children: [
                CustomSimpleText(
                  text: msg,
                  color: Colors.black,
                  fontSize: AppSizes.size16,
                ),
                5.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSimpleText(
                      text: msg2,
                      color: Colors.black,
                      fontSize: AppSizes.size16,
                      alignment: TextAlign.center,
                    ),

                  ],
                ),
              ],
            ),
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop(); // Close the dialog
          //     },
          //     child: CustomSimpleText(
          //       alignment: Alignment.centerRight,
          //       text: "Close",
          //       color: Colors.red,
          //       fontSize: AppSizes.size16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ],
        );
      },
    );
  }
}

