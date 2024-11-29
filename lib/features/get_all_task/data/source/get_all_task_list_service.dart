import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../core/app_component/app_component.dart';
import '../../../../core/network/configuration.dart';
import '../../../../core/status/status.dart';
import '../model/create_task_model.dart';
import '../model/delete_task_model.dart';
import '../model/get_all_task_list_model.dart';
import '../model/get_task_details_model.dart';

class GetAllTaskListModelListService {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<GetAllTaskListModel>?> getAllTask() async {
    Response<GetAllTaskListModel>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.getAllTask,
      responseCallback: (response, message) {
        var products = GetAllTaskListModel.fromJson(response);
        apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
  Future<Response<DeleteTaskModel>?> deleteTask(String id) async {
    Response<DeleteTaskModel>? apiResponse;

    await _dioClient.delete(
      path: "${NetworkConfiguration.deleteTask}$id",
      responseCallback: (response, message) {
        var products = DeleteTaskModel.fromJson(response);
        apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
  Future<Response<CreateTaskModel>?> createTask(String title, String description) async {
    Response<CreateTaskModel>? apiResponse;

    var formData = {
      "title": title,
      "description": description,
    };
    print("login credentials $formData");

    await _dioClient.post(
      path: NetworkConfiguration.createTask,
      request: formData,
      responseCallback: (response, message) {
        print("API response login data 1 ${response}"); // Print the full response to check

        // Ensure you are passing the full response to the LoginModel
        var loginModel = CreateTaskModel.fromJson(response);

        // Create a Response object with the parsed data
        apiResponse = Response.success(loginModel);
        logger.i("Login successful: $loginModel");
      },
      failureCallback: (message, status) {
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("API response create data ${apiResponse?.data?.data?.title}");
    return apiResponse;
  }
  Future<Response<GetTaskDetailsModel>?> getTaskDetails(String id) async {
    Response<GetTaskDetailsModel>? apiResponse;

    await _dioClient.get(
      path: "${NetworkConfiguration.getTask}$id",
      responseCallback: (response, message) {
        var products = GetTaskDetailsModel.fromJson(response);
        apiResponse = Response.success(products);
      },
      failureCallback: (message, status) {
        print("this is message error $message $status");
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("api response ${apiResponse?.data}");
    return apiResponse;
  }
}

