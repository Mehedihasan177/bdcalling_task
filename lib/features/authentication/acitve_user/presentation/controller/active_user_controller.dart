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
import '../../../../get_all_task/presentation/ui/widgets/custom_toast.dart';
import '../../../../widget/custom_elevatedButton/custom_text.dart';
import '../../data/model/active_user_model.dart';
import '../../domain/repository/active_user_repository.dart';
import '../../domain/usecase/active_user_pass_usecase.dart';

class ActiveUserController extends GetxController {
  var obscureText = true.obs;
  var code = "".obs;
  var passwordVisibility = false.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  final box = GetStorage();

  activeUserFunction(BuildContext context, String code) async {
    try {
      ActiveUserPassUseCase loginUseCase =
      ActiveUserPassUseCase(locator<ActiveUserRepository>());
      if (code.isEmpty) {
        errorToast(context: context, msg: "Please enter the active account code.");
      }  else {
        isLoading.value = true;
        update();
        var response = await loginUseCase(
            email: box.read("email"),
            code: code);
        print("this is data of active user ${response?.data?.status}");
        if (response?.data != null && response?.data?.status == "Success") {
            RouteGenerator.pushNamedAndRemoveAll(context, Routes.homepage);
        } else {
          if (!context.mounted) return;
          if (response?.data?.status == null) {
            errorToast(context: context, msg: response?.data?.error ?? '');
          }
        }
      }
    } catch (e) {
      isLoading.value = false;
      if(e.toString().contains("401")){
        errorToast(context: context, msg: "Invalid login credential!");
      }else{
        errorToast(context: context, msg: "Something went wrong. Please try again");
      }
      print("response?.data?.status ${e.toString()}");

      print(e.toString() ?? '');
    } finally {
      isLoading.value = false;
    }
    isLoading.value = false;
    update();
  }
}

