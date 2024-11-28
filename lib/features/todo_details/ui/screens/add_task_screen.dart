
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_project/features/todo_details/ui/controllers/task_controller.dart';
import 'package:todo_app_project/features/todo_details/ui/theme.dart';
import 'package:todo_app_project/features/todo_details/ui/widgets/buttonWidget.dart';
import 'package:todo_app_project/features/todo_details/ui/widgets/customAppBar_Widget.dart';
import 'package:todo_app_project/features/todo_details/ui/widgets/input_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController taskController = Get.find();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    taskController.selecteTime = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: CustomAppBar(
          leadingWidget: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: Obx(
          () => SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add Task",
                            style: TextStyle(
                                color:
                                    Get.isDarkMode ? Colors.white : darkGreyClr,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      InputField(
                        isEnabled: true,
                        hint: 'Enter Title',
                        label: 'Title',
                        iconOrdrop: 'icon',
                        controller: taskController.titleController.value,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        isEnabled: true,
                        hint: 'Enter Note',
                        label: 'Note',
                        iconOrdrop: 'icon',
                        controller: taskController.noteController.value,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        controller: taskController.dateController.value,
                        isEnabled: false,
                        hint: DateFormat.yMd().format(DateTime.now()),
                        label: 'Date',
                        iconOrdrop: 'button',
                        widget: IconButton(
                          icon: const Icon(Icons.date_range),
                          onPressed: () async {
                            _selectDate(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 165,
                              child: InputField(
                                isEnabled: false,
                                controller:
                                    taskController.startTimeController.value,
                                label: 'Start Time',
                                iconOrdrop: 'button',
                                hint: taskController.startDate.value.toString(),
                                widget: IconButton(
                                  icon: const Icon(Icons.access_time),
                                  onPressed: () async {
                                    _selectStartTime(context);
                                    // });
                                  },
                                ),
                              )),
                          SizedBox(
                              width: 165,
                              child: InputField(
                                controller:
                                    taskController.endTimeController.value,
                                isEnabled: false,
                                iconOrdrop: 'button',
                                label: 'End Time',
                                hint: taskController.endDate.value.toString(),
                                widget: IconButton(
                                  icon: const Icon(Icons.access_time),
                                  onPressed: () {
                                    _selectEndTime(context);
                                  },
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //_colorPallete(),
                         taskController.isAddTodoItem.value? const Center(child: CircularProgressIndicator()) :ButtonWidget(
                              label: 'Add Task',
                              onTap: () async {
                                
                                if (taskController
                                    .endTimeController.value.text.isEmpty) {
                                  taskController.endTimeController.value.text =
                                      DateFormat('hh:mm a').format(
                                          DateTime.now()
                                              .add(const Duration(minutes: 15)));
                                }
                                if (taskController
                                    .startTimeController.value.text.isEmpty) {
                                  taskController
                                          .startTimeController.value.text =
                                      DateFormat('hh:mm a')
                                          .format(DateTime.now());
                                }
                                if (taskController
                                    .dateController.value.text.isEmpty) {
                                  taskController.dateController.value.text =
                                      DateFormat.yMd().format(DateTime.now());
                                }
                                
                                taskController.addToDoList().then((value) => taskController.clearData()).then((value) => taskController.fetchToDoList().then((value) => Navigator.pop(context)));
                              },
                              color: primaryClr)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null) {
      taskController.dateController.value.text =
          DateFormat('MM/dd/yyyy').format(picked);
    }
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    String formattedTime = selected!.format(context);
    // setState(() {
    taskController.startTimeController.value.text = formattedTime;
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    String formattedTime = selected!.format(context);
    // setState(() {
    taskController.endTimeController.value.text = formattedTime;
    // });
  }
}
