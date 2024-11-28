import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app_project/core/core/extensions/extensions.dart';

import '../../../../../../core/core/widget/blur_widget.dart';
import '../../../../../../core/routes/route_name.dart';
import '../../../../../../core/routes/router.dart';
import '../../../../../core/utils/consts/app_assets.dart';
import '../../../../../core/utils/consts/app_colors.dart';
import '../../../../../core/utils/consts/app_sizes.dart';
import '../../../../widget/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../../widget/custom_elevatedButton/custom_text.dart';
import '../../../../widget/custom_richtext/custom_richtext.dart' as customRichText;
import '../../../../widget/custom_textfield/custom_textfield.dart';
import '../controller/signup_controller.dart';
import '../widget/custom_dialog.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  var controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 106,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.slightWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: CustomSimpleText(
                              text: "Video",
                              alignment: TextAlign.end,
                              fontSize: AppSizes.size40,
                              fontWeight: FontWeight.w600,
                            ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: CustomSimpleText(
                            text: "E-commerce",
                            alignment: TextAlign.end,
                            fontSize: AppSizes.size27,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                    40.ph,
                    Container(
                      height: MediaQuery.of(context).size.height * 0.76,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.slightWhite,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(96),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              20.ph,
                              CustomSimpleText(
                                text: "Registration",
                                alignment: TextAlign.start,
                                fontSize: AppSizes.size24,
                                fontWeight: FontWeight.w600,
                              ),
                              30.ph,
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showCustomDialog(context: context);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: controller
                                              .pickedImage.value.path.isNotEmpty
                                          ? Image.file(
                                              controller.pickedImage.value,
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : Icon(
                                              Icons.person,
                                              size: 100,

                                            ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Icon(Icons.camera_alt))
                                ],
                              ),
                              20.ph,
                              SizedBox(
                                height: 45,
                                child: CustomTextfield(
                                  controller: controller.firstName.value,
                                  hintText: "Enter first name",
                                  lebelText: "First Name",
                                ),
                              ),
                              20.ph,
                              SizedBox(
                                height: 45,
                                child: CustomTextfield(
                                  controller: controller.lastName.value,
                                  hintText: "Enter last name",
                                  lebelText: "Last Name",
                                ),
                              ),
                              20.ph,
                              SizedBox(
                                height: 45,
                                child: CustomTextfield(
                                  controller: controller.emailController.value,
                                  hintText: "Enter your email",
                                  lebelText: "Email",
                                ),
                              ),
                              20.ph,
                              SizedBox(
                                height: 45,
                                child: CustomTextfield(
                                  controller: controller.phoneNumber.value,
                                  hintText: "Enter your phone number",
                                  lebelText: "Phone Number",
                                ),
                              ),
                              20.ph,
                              SizedBox(
                                height: 45,
                                child: CustomTextfield(
                                  controller: controller.addressController.value,
                                  hintText: "Enter your address",
                                  lebelText: "Address",
                                ),
                              ),
                              20.ph,
                              SizedBox(
                                height: 45,
                                child: Obx(
                                  () => CustomTextfield(
                                    controller:
                                        controller.passwordController.value,
                                    hintText: "Enter your password",
                                    lebelText: "Password",
                                    needObscureText: true,
                                    obscureText:
                                        controller.obscureTextPassword.value,
                                    onPress: () {
                                      controller.obscureTextPassword.value =
                                          !controller.obscureTextPassword.value;
                                    },
                                  ),
                                ),
                              ),
                              20.ph,
                              SizedBox(
                                height: 45,
                                child: Obx(
                                  () => CustomTextfield(
                                    controller: controller
                                        .confirmPasswordController.value,
                                    hintText: "Enter your password again",
                                    lebelText: "Confirm Password",
                                    needObscureText: true,
                                    obscureText: controller
                                        .obscureTextConfirmPassword.value,
                                    onPress: () {
                                      controller.obscureTextConfirmPassword
                                              .value =
                                          !controller
                                              .obscureTextConfirmPassword.value;
                                    },
                                  ),
                                ),
                              ),
                              40.ph,
                              // controller.isLoading.value == true
                              //     ? const CircularProgressIndicator()
                              //     :
                              CustomElevatedButton(
                                hexColor: HexColor('#072844'),
                                text: "Sign up",
                                onPress: () {
                                  controller.submitSignupData(context);
                                },
                              ),
                              10.ph,
                           controller.signinController.isLoading.value ? const Center(
                             child: CircularProgressIndicator(),
                           ) : customRichText.CustomRichText(
                                title: "Sign in",
                                titleTextColor: AppColors.orange,
                                heading: "Already have an account? ",
                                headingFontSize: AppSizes.size11,
                                titleFontSIze: AppSizes.size11,
                                titleFontWeight: FontWeight.w500,
                                headingFontWeight: FontWeight.w500,
                                headingTextColor: AppColors.slightBlue,
                                onPress: () {
                                  RouteGenerator.pushNamed(
                                      context, Routes.signinPage);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 10,
                  top: 50,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CustomPaint(
                          foregroundPainter: CircleBlurPainter(
                              circleWidth: 30, blurSigma: 1.5),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Icon(
                              Icons.person,
                              size: 55,

                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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
                        controller.pickImageFromGallery();
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
                        controller.pickImageCamera();
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
