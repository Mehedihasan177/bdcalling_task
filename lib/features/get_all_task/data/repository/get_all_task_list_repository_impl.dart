import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/get_all_task_list_repository.dart';
import '../model/create_task_model.dart';
import '../model/delete_task_model.dart';
import '../model/get_all_task_list_model.dart';
import '../model/get_task_details_model.dart';
import '../source/get_all_task_list_service.dart';
class GetAllTaskListModelListRepositoryImpl extends GetAllTaskListModelListRepository {
  GetAllTaskListModelListRepositoryImpl(super.getAllTaskListModelListService);

  @override
  Future<Response<GetAllTaskListModel>?> getAllTask() async {
    Response<GetAllTaskListModel>? apiResponse;
    apiResponse = await getAllTaskListModelListService.getAllTask();
    return apiResponse;
  }
  @override
  Future<Response<DeleteTaskModel>?> deleteTask({String? id}) async {
    Response<DeleteTaskModel>? apiResponse;
    apiResponse = await getAllTaskListModelListService.deleteTask(id ?? '');
    return apiResponse;
  }
  @override
  Future<Response<GetTaskDetailsModel>?> getTaskDetails({String? id}) async {
    Response<GetTaskDetailsModel>? apiResponse;
    apiResponse = await getAllTaskListModelListService.getTaskDetails(id ?? '');
    return apiResponse;
  }
  @override
  Future<Response<CreateTaskModel>?> createTask({String? title, String? description}) async {
    Response<CreateTaskModel>? apiResponse;
    apiResponse = await getAllTaskListModelListService.createTask( title ?? '',  description ?? '');
    return apiResponse;
  }
}
