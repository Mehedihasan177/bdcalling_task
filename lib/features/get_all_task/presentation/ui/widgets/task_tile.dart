import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_project/features/get_all_task/data/model/get_all_task_list_model.dart';

import '../../../../../core/app_component/app_component.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../controller/task_controller.dart';
import '../theme.dart';

class TaskTile extends StatefulWidget {
  final MyTasks? task;
  final List<MyTasks>? allData;
  final int index;
  const TaskTile({Key? key, required this.task, required this.allData, required this.index, }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
var controller = locator<TaskController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.17
          : 100,
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.7,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: MediaQuery.of(context).orientation == Orientation.portrait
              ? 20
              : 0),
      decoration: BoxDecoration(
          color:  Colors.green,
          borderRadius: BorderRadius.circular(10)),
      child:  InkWell(
        onTap: (){
          RouteGenerator.pushNamed(context, Routes.getTaskDetails);
          controller.getTaskDetailsFunc(id: widget.task?.sId);

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.task?.title}',
                  style: Themes().taskTileHeadingTextStyle,
                ),
                InkWell(
                  onTap: () {
                    controller.getDelete(id: widget.task?.sId, data: widget.allData, index: widget.index);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.task?.description}',
                  style: const TextStyle(color: Colors.white),
                ),



              ],
            ))
          ],
        ),
      ),



    );
  
  }
}
