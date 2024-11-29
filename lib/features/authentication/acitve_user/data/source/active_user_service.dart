
import 'dart:convert';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../../core/source/session_manager.dart';
import '../../../../../core/app_component/app_component.dart';
import '../../../../../core/network/configuration.dart';
import '../../../../../core/status/status.dart';
import '../model/active_user_model.dart';
import 'package:dio/dio.dart' as dio;

class ActiveUserService {
  final DioClient _dioClient = locator<DioClient>();

// To decode the response if needed

  Future<Response<ActiveUserModel>?> loginWithIdPass(String email, String code) async {
    Response<ActiveUserModel>? apiResponse;

    var formData = {
      "email": email,
      "code": code,
    };
    print("login credentials $formData");

    await _dioClient.post(
      path: NetworkConfiguration.activeUser,
      request: formData,
      responseCallback: (response, message) {
        print("API response login data 1 ${response}"); // Print the full response to check

        // Ensure you are passing the full response to the LoginModel
        var code = ActiveUserModel.fromJson(response);

        // Create a Response object with the parsed data
        apiResponse = Response.success(code);
        logger.i("Login successful: $code");
      },
      failureCallback: (message, status) {
        apiResponse = Response.error(message, status);
      },
    );

    logger.e("API response login data ${apiResponse?.data?.status}");
    return apiResponse;
  }
}
