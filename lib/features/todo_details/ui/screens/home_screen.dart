// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app_project/features/todo_details/ui/controllers/task_controller.dart';
import 'package:todo_app_project/features/todo_details/ui/screens/add_task_screen.dart';
import 'package:todo_app_project/features/todo_details/ui/size_config.dart';
import 'package:todo_app_project/features/todo_details/ui/theme.dart';
import 'package:todo_app_project/features/todo_details/ui/widgets/customAppBar_Widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_project/features/todo_details/ui/widgets/task_tile.dart';

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
      appBar: const CustomAppBar(),
      body: GetBuilder<TaskController>(
        initState: (state) {
          _taskController.fetchToDoList();
        },
        builder: (context) {
          return Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: Themes().homeScreenSubHeadingTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TO DO',
                          style: Themes().homeScreenHeadingTextStyle,
                        ),
                        InkWell(
                          onTap: (){
                            // _taskController.deleteAllTasks();
                            _taskController.deleteCollectionAndReturnItem();
                          },
                          child: const Icon(Icons.delete, color: Colors.red, size: 25,),
                        )
                      ],
                    ),
                  ],
                ),
                _tasks(),
              ],
            ),
          
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryClr,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Get.to(() => const AddTaskScreen(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 500)),
      ),
    );
  }

  Widget _tasks() {
    return Expanded(child: Obx(() {
      if(_taskController.isLoading.value){
        return const Center(child: CircularProgressIndicator(),);
      }
      else if (_taskController.dataList.isEmpty) {
        return _noTasksMessage();
      } else {
        return Obx(() => AnimationLimiter(
          child: ListView.builder(
              scrollDirection:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal,
              itemCount: _taskController.dataList.length,
              itemBuilder: (BuildContext context, int index) {
                var task = _taskController.dataList[index];
                
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(milliseconds: 500 + index * 20),
                    child: SlideAnimation(
                      horizontalOffset: 400.0,
                      child: FadeInAnimation(
                        child: TaskTile(task: task),
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
