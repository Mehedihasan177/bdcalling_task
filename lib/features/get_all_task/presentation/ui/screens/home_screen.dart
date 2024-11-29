// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_project/core/network/configuration.dart';
import 'package:todo_app_project/features/widget/cached_image_network/custom_cached_image_network.dart';

import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../main.dart';
import '../../../../widget/custom_appbar/custom_appbar.dart';
import '../../controller/task_controller.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = Get.put(TaskController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SizeConfig.orientation = Orientation.portrait;
    SizeConfig.screenHeight = 100;
    SizeConfig.screenWidth = 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: const CustomAppBar(title: '',),
      body: SafeArea(
        child: GetBuilder<TaskController>(initState: (state) {
          _taskController.fetchTaskList();
        }, builder: (controller) {
          return Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: Themes().homeScreenSubHeadingTextStyle,
                    ),
                    InkWell(
                      onTap: (){
                        RouteGenerator.pushNamed(context, Routes.profile);
                      },
                      child: CustomCachedImageNetwork(
                          imageUrl:
                              "${NetworkConfiguration.baseUrl}${box.read("photo")}",
                          height: 40,
                          weight: 40),
                    )
                  ],
                ),
                _tasks(),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryClr,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        // onPressed: () {},
        onPressed: () => Get.to(() => const AddTaskScreen(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 500)),
      ),
    );
  }

  Widget _tasks() {
    return Expanded(child: Obx(() {
      if (_taskController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (_taskController.dataList.value.data?.myTasks?.isEmpty ??
          false) {
        return _noTasksMessage();
      } else {
        return Obx(
          () => AnimationLimiter(
            child: ListView.builder(
                scrollDirection:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                itemCount: _taskController.dataList.value.data?.myTasks?.length,
                itemBuilder: (BuildContext context, int index) {
                  var task =
                      _taskController.dataList.value.data?.myTasks?[index];

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(milliseconds: 500 + index * 20),
                    child: SlideAnimation(
                      horizontalOffset: 400.0,
                      child: FadeInAnimation(
                        child: TaskTile(
                            task: task,
                            allData:
                                _taskController.dataList.value.data?.myTasks,
                            index: index),
                      ),
                    ),
                  );
                }),
          ),
        );
      }
    }));
  }

  Widget _noTasksMessage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MediaQuery.of(context).orientation == Orientation.portrait
                ? const SizedBox(
                    height: 0,
                  )
                : const SizedBox(
                    height: 50,
                  ),
            SvgPicture.asset(
              'images/task.svg',
              height: 200,
              color: primaryClr.withOpacity(0.5),
              semanticsLabel: 'Tasks',
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("There Is No Tasks"),
          ],
        ),
      ),
    );
  }
}
