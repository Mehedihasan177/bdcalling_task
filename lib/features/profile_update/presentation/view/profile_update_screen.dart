import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app_project/core/core/extensions/extensions.dart';
import '../../../../core/network/configuration.dart';
import '../../../../core/utils/consts/app_colors.dart';
import '../../../../main.dart';
import '../../../widget/cached_image_network/custom_cached_image_network.dart';
import '../../../widget/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../widget/custom_elevatedButton/custom_text.dart';
import '../../../widget/custom_textfield/custom_textfield.dart';
import '../controller/profile_update_controller.dart';

class ProfileUpdateScreen extends StatelessWidget {
   ProfileUpdateScreen({super.key});
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileUpdateController(),
        builder: (controller) {
          return Obx(() => Scaffold(
                backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              title: const CustomSimpleText(
                text: "Profile",
              ),
            ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.showCustomDialog(context: context);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child:
                                  controller.pickedImage.value.path.isNotEmpty
                                      ? Image.file(
                                    controller.pickedImage.value,  // Local picked image
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:  CustomCachedImageNetwork(
                                      imageUrl: "${NetworkConfiguration.baseUrl}${box.read("photo")}",
                                      height: 100,
                                      weight: 100,
                                    ),
                                  ),

                            ),
                          ),
                          const Positioned(
                              bottom: 5,
                              right: 0,
                              // top: 0,
                              left: 70,
                              child: Icon(Icons.camera_alt)),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controller.isClickable.value = false;
                                      FocusScope.of(context)
                                          .requestFocus(focusNode);
                                      controller.confirmPasswordController.value.text = controller.profileModel.value.data?.password ?? '' ;
                                    },
                                    icon: Icon(
                                      Icons.edit_note_sharp,
                                      color: AppColors.green,
                                    )),
                                controller.isClickable.value == false
                                    ? IconButton(
                                        onPressed: () {
                                          controller.isClickable.value = true;
                                          controller.confirmPasswordController.value.text =  '' ;
                                          focusNode.unfocus();
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          color: AppColors.red,
                                        ))
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      20.ph,
                      SizedBox(
                        height: 45,
                        child: CustomTextfield(
                          controller: controller.firstNameController.value,
                          hintText: "Enter name",
                          lebelText: "First Name",
                          readOnly: controller.isClickable.value,
                          focusNode: focusNode,
                        ),
                      ),
                      20.ph,
                      SizedBox(
                        height: 45,
                        child: CustomTextfield(
                          controller: controller.lastNameController.value,
                          hintText: "Enter last name",
                          lebelText: "Last Name",
                          readOnly: controller.isClickable.value,
                        ),
                      ),
                      20.ph,
                      SizedBox(
                        height: 45,
                        child: CustomTextfield(
                          controller: controller.addressController.value,
                          hintText: "Enter Address",
                          lebelText: "Address",
                          readOnly: controller.isClickable.value,
                        ),
                      ),
                      20.ph,
                      SizedBox(
                        height: 45,
                        child: CustomTextfield(
                          controller: controller.passwordController.value,
                          hintText: "Enter password",
                          lebelText: "Password",
                          readOnly: controller.isClickable.value,
                        ),
                      ),
                      20.ph,
                      Visibility(
                        visible: controller.isClickable.value == false ? true : false,
                        child: SizedBox(
                          height: 45,
                          child: CustomTextfield(
                            controller: controller.confirmPasswordController.value,
                            hintText: "Enter confirm password",
                            lebelText: "Confirm Password",
                            readOnly: controller.isClickable.value,
                          ),
                        ),
                      ),

                      Visibility(
                          visible: controller.isClickable.value == false ? true : false,
                          child: SizedBox(height: 20,),
                      ),
                      Visibility(
                        visible: controller.isClickable.value == false ? true : false,
                        child: Obx(
                          () => controller.isLoading.value == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomElevatedButton(
                                  hexColor: HexColor('#072844'),
                                  text: "Update",
                                  onPress: () {
                                    controller.submitProfileUpdate(context);
                                  },
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
