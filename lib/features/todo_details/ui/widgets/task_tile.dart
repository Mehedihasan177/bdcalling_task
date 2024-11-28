import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_project/features/todo_details/ui/controllers/task_controller.dart';
import 'package:todo_app_project/features/todo_details/data/model/todo_model.dart';
import 'package:todo_app_project/features/todo_details/ui/theme.dart';

class TaskTile extends StatefulWidget {
  final TodoList task;
  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final TaskController _taskController = Get.put(TaskController());

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
          color: widget.task.isComplete == false ? bluishClr : Colors.green,
          borderRadius: BorderRadius.circular(10)),
      child: Obx(() => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.task.title}',
                  style: Themes().taskTileHeadingTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_sharp,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text('${widget.task.startTime} - ${widget.task.endTime}',
                            style: const TextStyle(color: Colors.white)),
                            Text(
                          DateFormat('M/d/yyyy').format(widget.task.date ?? DateTime.now()),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.task.note}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       _taskController.isComplete.value? const Center(child: CircularProgressIndicator(),) : widget.task.isComplete == false
                            ?  InkWell(
                              onTap: (){
                                // _taskController.markAsCompleted(task.id);
                                setState(() {
                                  widget.task.isComplete = true;
                                });
                                  
                                
                                _taskController.completeTodoListItem(documentId: widget.task.id);
                              },
                              child: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 25,)) :
                              
                             const SizedBox(),
            
                             const SizedBox(width: 15,),
                          InkWell(
                            onTap: (){
                              _taskController.dataList.remove(widget.task);
                              _taskController.deleteTodoList(documentId: widget.task.id);
                              // _taskController.deleteTask(task.id);
                            },
                            child: const Icon(Icons.delete_forever_rounded, color: Colors.red, size: 25)),
                              
                      ],
                    )
                  
                  
                  ],
                ))
              ],
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: widget.task.isComplete == false
                ? const Text('TODO', style: TextStyle(color: Colors.white))
                : const Text('COMPLETED', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    )
    );
  
  }
}
