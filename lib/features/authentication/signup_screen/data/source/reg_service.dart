
import 'dart:convert';
import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../../core/app_component/app_component.dart';
import '../../../../../core/network/configuration.dart';
import '../../../../../core/status/status.dart';
import '../../../../../main.dart';
import '../model/registration_model.dart';
import 'package:dio/dio.dart' as dio;

class RegService {
  final DioClient _dioClient = locator<DioClient>();

  Future<Response<RegistrationModel>?> regPass(dio.FormData data) async {
    Response<RegistrationModel>? apiResponse;

    print("Request fields:");
    for (var field in data.fields) {
      print("Key: ${field.key}, Value: ${field.value}");
    }

    print("Request files:");
    for (var file in data.files) {
      print("Key: ${file.key}, File name: ${file.value.filename}, File length: ${file.value.length}");
    }
   await _dioClient.post(
      path: NetworkConfiguration.registration,
      request: data,
      responseCallback: (response, message) {
          // Handle successful response
          var registrationModel = RegistrationModel.fromJson(response);
          apiResponse = Response.success(registrationModel);
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
