
import 'dart:convert';

import '../../../../../../core/source/dio_client.dart';
import '../../../../../../core/source/model/api_response.dart';
import '../../../../core/app_component/app_component.dart';
import '../../../../core/network/configuration.dart';
import '../../../../core/status/status.dart';
import '../../../../main.dart';
import '../../../get_all_task/presentation/ui/widgets/custom_toast.dart';
import '../model/profile_model.dart';
import 'package:dio/dio.dart'as dio;

import '../model/profile_update_model.dart';

class ProfileUpdateService {
  final DioClient _dioClient = locator<DioClient>();
  Future<Response<ProfileModel>?> profile() async {
    Response<ProfileModel>? apiResponse;

    await _dioClient.get(
      path: NetworkConfiguration.myProfile,
      responseCallback: (response, message) {
        var products = ProfileModel.fromJson(response);
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
  Future<Response<ProfileUpdateModel>?> profileUpdatePass(dio.FormData data) async {
    Response<ProfileUpdateModel>? apiResponse;


   await _dioClient.petch(
      path: NetworkConfiguration.updateProfile,
      request: data,
      responseCallback: (response, message) {

          // Handle successful response
          var profile = ProfileUpdateModel.fromJson(response);
          apiResponse = Response.success(profile);


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
