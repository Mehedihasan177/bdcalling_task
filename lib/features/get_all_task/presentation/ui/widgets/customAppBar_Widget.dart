// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo_app_project/core/services/theme_services.dart';
import 'package:get/get.dart';
import '../theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.leadingWidget}) : super(key: key);
  final Widget? leadingWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("To Do App", style: TextStyle(fontWeight: FontWeight.bold),),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      leading: leadingWidget,
      actions: [
        IconButton(
          onPressed: () {
            ThemeServices().switchTheme();
          },
          icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined,
          ),
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
