import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app_project/core/core/extensions/extensions.dart';
import '../../../../../../core/core/widget/blur_widget.dart';
import '../../../../../../core/routes/route_name.dart';
import '../../../../../../core/routes/router.dart';
import '../../../../../core/app_component/app_component.dart';
import '../../../../../core/utils/consts/app_assets.dart';
import '../../../../../core/utils/consts/app_colors.dart';
import '../../../../../core/utils/consts/app_sizes.dart';
import '../../../../widget/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../../widget/custom_elevatedButton/custom_text.dart';
import '../../../../widget/custom_textfield/custom_textfield.dart';
import '../controller/signin_controller.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  var controller = locator<SigninController>();
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
                      color: AppColors.deepGrey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: CustomSimpleText(
                              text: "Task",
                              alignment: TextAlign.end,
                              fontSize: AppSizes.size40,
                              fontWeight: FontWeight.w600,
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: CustomSimpleText(
                            text: "Management",
                            alignment: TextAlign.end,
                            fontSize: AppSizes.size27,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                    40.ph,
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.slightWhite,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(96),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            99.ph,
                            CustomSimpleText(
                              text: "Login",
                              alignment: TextAlign.start,
                              fontSize: AppSizes.size24,
                              fontWeight: FontWeight.w600,
                            ),
                            60.ph,
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
                              child: Obx(
                                () => CustomTextfield(
                                  controller:
                                      controller.passwordController.value,
                                  hintText: "Enter your password",
                                  lebelText: "Password",
                                  needObscureText: true,
                                  obscureText: controller.obscureText.value,
                                  onPress: () {
                                    controller.obscureText.value =
                                        !controller.obscureText.value;
                                  },
                                ),
                              ),
                            ),
                            40.ph,
                            controller.isLoading.value == true
                                ? const CircularProgressIndicator()
                                : CustomElevatedButton(
                                    hexColor: HexColor('#072844'),
                                    text: "Sign in",
                                    onPress: () {
                                      controller.submitLoginData(context, from: "signin");
                                    },
                                  ),
                            10.ph,
                            CustomRichText(
                              title: "Sign up",
                              titleTextColor: AppColors.orange,
                              heading: "Don't Have Account? ",
                              headingFontSize: AppSizes.size11,
                              titleFontSIze: AppSizes.size11,
                              titleFontWeight: FontWeight.w500,
                              headingFontWeight: FontWeight.w500,
                              headingTextColor: AppColors.slightBlue,
                              onPress: () {
                                RouteGenerator.pushNamed(
                                    context, Routes.signupPage);
                              },
                            )
                          ],
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
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(child: Image.asset("images/logo.png", height: 52, width:  52,)),
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
}
