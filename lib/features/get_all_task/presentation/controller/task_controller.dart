import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_project/core/app_component/app_component.dart';
import 'package:todo_app_project/features/get_all_task/data/model/get_task_details_model.dart';
import 'package:todo_app_project/features/get_all_task/presentation/ui/widgets/custom_toast.dart';
import 'package:todo_app_project/main.dart';

import '../../data/model/create_task_model.dart';
import '../../data/model/delete_task_model.dart';
import '../../data/model/get_all_task_list_model.dart';
import '../../domain/repository/get_all_task_list_repository.dart';
import '../../domain/usecase/get_all_task_list_pass_usecase.dart';

class TaskController extends GetxController {
  var selectDate = DateTime.now().obs;
 var dataList = GetAllTaskListModel().obs;
 var getDeleteModel = DeleteTaskModel().obs;
 var createTaskModel = CreateTaskModel().obs;
 var getTaskDetailsModel = GetTaskDetailsModel().obs;
   final Rx<TextEditingController> titleController = TextEditingController().obs;
  final Rx<TextEditingController> descriptionController = TextEditingController().obs;
  final Rx<TextEditingController> dateController = TextEditingController().obs;
  final Rx<TextEditingController> startTimeController = TextEditingController().obs;
  final Rx<TextEditingController> endTimeController = TextEditingController().obs;

final RxBool isAddTodoItem = false.obs;
final RxBool isGetTaskDetailsLoading = false.obs;
final RxBool isComplete = false.obs;
final RxBool isLoading = false.obs;
 DateTime  selectedDate = DateTime.now();
 TimeOfDay  selecteTime = TimeOfDay.now();
  RxString startDate = DateFormat('hh:mm a').format(DateTime.now()).obs;
  RxString endDate =
      DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 15))).obs;

  void fetchTaskList({ String? from}) async {
    if(from !="delete"){
    isLoading.value = true;
    }
    try {
      GetAllTaskListModelListPassUseCase userOrderListPassUseCase =
      GetAllTaskListModelListPassUseCase(locator<GetAllTaskListModelListRepository>());
      var response = await userOrderListPassUseCase();
      // Additional logic based on the response
      if (response?.data?.data != null) {
        dataList.value = response?.data ?? GetAllTaskListModel();
        isLoading.value = false;
      }
    } catch (error) {
      // isLoading.value = false;
      // Handle errors here, if needed
    }finally{
      isLoading.value = false;
    }

  }
  void getDelete({String? id, List<MyTasks>? data, required int index}) async {
    isLoading.value = true;
    try {
      DeleteTaskModelPassUseCase deleteTaskModelPassUseCase =
      DeleteTaskModelPassUseCase(locator<GetAllTaskListModelListRepository>());
      var response = await deleteTaskModelPassUseCase(id: id);
      // Additional logic based on the response
      if (response?.data?.data != null && response?.data?.status == "Success") {
        getDeleteModel.value = response?.data ?? DeleteTaskModel();
        isLoading.value = false;
        data?.removeAt(index);
        fetchTaskList(from: "delete");
        successToast(context: navigatorKey.currentContext!, msg: response?.data?.message ?? '');
      }
    } catch (error) {
      isLoading.value = false;
      // Handle errors here, if needed
    }finally{
      isLoading.value = false;
    }

  }
  void getTaskDetailsFunc({String? id}) async {
    isLoading.value = true;
    try {
      GetTaskDetailsModelPassUseCase getTaskDetailsModelPassUseCase =
      GetTaskDetailsModelPassUseCase(locator<GetAllTaskListModelListRepository>());
      var response = await getTaskDetailsModelPassUseCase(id: id);
      // Additional logic based on the response
      if (response?.data?.data != null && response?.data?.status == "Success") {
        getTaskDetailsModel.value = response?.data ?? GetTaskDetailsModel();
        isLoading.value = false;
      }
    } catch (error) {
      isLoading.value = false;
      // Handle errors here, if needed
    }finally{
      isLoading.value = false;
    }
  }
  Future<void> addToDoList() async {
    isAddTodoItem.value = true;
    try {
      CreateTaskModelPassUseCase createTaskModelPassUseCase =
      CreateTaskModelPassUseCase(locator<GetAllTaskListModelListRepository>());
      var response = await createTaskModelPassUseCase(title: titleController.value.text, description: descriptionController.value.text);
      if (response?.data != null && response?.data?.status == "Success" ) {
        createTaskModel.value = response?.data ?? CreateTaskModel();
successToast(context: navigatorKey.currentContext!, msg: response?.data?.message ?? '');
        isAddTodoItem.value = false;
        fetchTaskList();
      }

    } catch (error) {
      isAddTodoItem.value = false;
      errorToast(context: navigatorKey.currentContext!, msg: error.toString());
      // Handle errors here, if needed
    }

    // return dataList;
  }

//   Future<void> deleteTodoList({String? documentId}) async {
//     isAddTodoItem.value = true;
//     try {
//       final addToDoListPassUseCase = DeleteTodoPassUseCase(locator<ToDoDetailsRepository>());
//       var response = await addToDoListPassUseCase(documentId: documentId ?? '');
//       if (response.isBlank == false) {
// // successToast(context: navigatorKey.currentContext!, msg: "Successfully Added");
//         isAddTodoItem.value = false;
//       }
//
//     } catch (error) {
//       errorToast(context: navigatorKey.currentContext!, msg: error.toString());
//       // Handle errors here, if needed
//     }
//   }
//   Future<void> completeTodoListItem({String? documentId}) async {
//     isComplete.value = true;
//     try {
//       final addToDoListPassUseCase = CompleteTodoPassUseCase(locator<ToDoDetailsRepository>());
//       var response = await addToDoListPassUseCase(documentId: documentId ?? '');
//       if (response.isBlank == false) {
// // successToast(context: navigatorKey.currentContext!, msg: "Successfully Added");
//         isComplete.value = false;
//       }
//
//     } catch (error) {
//       errorToast(context: navigatorKey.currentContext!, msg: error.toString());
//       // Handle errors here, if needed
//     }finally{
//       isComplete.value = false;
//     }
//   }
//   Future<void> deleteCollectionAndReturnItem() async {
//     isComplete.value = true;
//     try {
//       final addToDoListPassUseCase = DeleteCollectionAndReturnItem(locator<ToDoDetailsRepository>());
//       var response = await addToDoListPassUseCase();
//       if (response.isBlank == false) {
//         dataList.clear();
// // successToast(context: navigatorKey.currentContext!, msg: "Successfully Added");
//         isComplete.value = false;
//       }
//
//     } catch (error) {
//       errorToast(context: navigatorKey.currentContext!, msg: error.toString());
//       // Handle errors here, if needed
//     }finally{
//       isComplete.value = false;
//     }
//   }
void clearData(){
  titleController.value.text = '';
  descriptionController.value.text = '';
  startTimeController.value.text = '';
  endTimeController.value.text = '';
  dateController.value.text = '';
  isAddTodoItem.value = false;
}
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar({required String message, required BuildContext context, required MaterialColor color}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(message),
  ));
}

}
