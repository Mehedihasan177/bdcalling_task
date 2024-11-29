
import 'package:dio/dio.dart'as dio;

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/create_task_model.dart';
import '../../data/model/delete_task_model.dart';
import '../../data/model/get_all_task_list_model.dart';
import '../../data/model/get_task_details_model.dart';
import 'get_all_task_list_usecase.dart';

class GetAllTaskListModelListPassUseCase extends GetAllTaskListModelListUseCase {
  GetAllTaskListModelListPassUseCase(super.getAllTaskListModelListService);

  Future<Response<GetAllTaskListModel>?> call() async {
    var response = await getAllTaskListModelListRepository.getAllTask();
    return response;
  }
}
class DeleteTaskModelPassUseCase extends DeleteTaskModelUseCase {
  DeleteTaskModelPassUseCase(super.getAllTaskListModelListService);

  Future<Response<DeleteTaskModel>?> call({String? id}) async {
    var response = await getAllTaskListModelListRepository.deleteTask(id: id ?? '');
    return response;
  }
}
class GetTaskDetailsModelPassUseCase extends GetTaskDetailsModelUseCase {
  GetTaskDetailsModelPassUseCase(super.getAllTaskListModelListService);

  Future<Response<GetTaskDetailsModel>?> call({String? id}) async {
    var response = await getAllTaskListModelListRepository.getTaskDetails(id: id ?? '');
    return response;
  }
}

class CreateTaskModelPassUseCase extends CreateTaskModelUseCase {
  CreateTaskModelPassUseCase(super.getAllTaskListModelListService);

  Future<Response<CreateTaskModel>?> call({String? title, String? description}) async {
    var response = await getAllTaskListModelListRepository.createTask(title: title ?? '', description: description);
    return response;
  }
}


