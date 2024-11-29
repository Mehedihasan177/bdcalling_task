
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

    print("the reg data is ${data.fields}");
    for (var fileEntry in data.files) {
      print("Key: ${fileEntry.key}");
      var file = fileEntry.value; // MultipartFile object
      print("File name: ${file.filename}");

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
