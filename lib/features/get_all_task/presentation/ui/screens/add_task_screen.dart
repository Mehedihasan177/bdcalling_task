
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_project/features/get_all_task/presentation/controller/task_controller.dart';
import 'package:todo_app_project/features/get_all_task/presentation/ui/widgets/customAppBar_Widget.dart';
import 'package:todo_app_project/features/get_all_task/presentation/ui/widgets/input_field.dart';
import 'package:todo_app_project/features/widget/custom_elevatedButton/custom_text.dart';

import '../../../../../core/app_component/app_component.dart';
import '../theme.dart';
import '../widgets/buttonWidget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var taskController = locator<TaskController>();
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios)),
          title: const CustomSimpleText(text: "Add Task", ),
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
                        hint: 'Enter Description',
                        label: 'Description',
                        iconOrdrop: 'icon',
                        controller: taskController.descriptionController.value,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      taskController.isAddTodoItem.value? const Center(child: CircularProgressIndicator()) :ButtonWidget(
                           label: 'Add Task',
                           onTap: () async {
                             taskController.addToDoList();
                           },
                           color: primaryClr)
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
