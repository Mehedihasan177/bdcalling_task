

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/create_task_model.dart';
import '../../data/model/delete_task_model.dart';
import '../../data/model/get_all_task_list_model.dart';
import '../../data/model/get_task_details_model.dart';
import '../../data/source/get_all_task_list_service.dart';
abstract class GetAllTaskListModelListRepository {
  final GetAllTaskListModelListService getAllTaskListModelListService;

  GetAllTaskListModelListRepository(this.getAllTaskListModelListService);

  Future<Response<GetAllTaskListModel>?> getAllTask();
  Future<Response<DeleteTaskModel>?> deleteTask({String? id});
  Future<Response<GetTaskDetailsModel>?> getTaskDetails({String? id});
  Future<Response<CreateTaskModel>?> createTask({String? title, String? description});
}
