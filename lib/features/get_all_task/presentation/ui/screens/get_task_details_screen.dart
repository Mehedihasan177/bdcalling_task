import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_project/core/core/extensions/extensions.dart';
import 'package:todo_app_project/core/utils/consts/app_colors.dart';
import 'package:todo_app_project/core/utils/consts/app_sizes.dart';
import 'package:todo_app_project/features/get_all_task/presentation/controller/task_controller.dart';

import '../../../../widget/custom_elevatedButton/custom_text.dart';

class GetTaskDetailsScreen extends StatelessWidget {
  const GetTaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
        init: TaskController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              title: const CustomSimpleText(
                text: "Task Details",
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(title: controller.getTaskDetailsModel.value.data?.title ?? '', headingTextColor: AppColors.orange, heading: "Title: ", titleFontSIze: AppSizes.size17, titleTextColor: Colors.black,),
                  10.ph,
                  CustomRichText(title: controller.getTaskDetailsModel.value.data?.description ?? '', headingTextColor: AppColors.orange, heading: "Description: ", titleFontSIze: AppSizes.size17, titleTextColor: Colors.black,),

                ],
              ),
            ),
          );
        });
  }
}
