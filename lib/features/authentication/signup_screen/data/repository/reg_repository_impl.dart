
import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/reg_repository.dart';
import '../model/registration_model.dart';
import '../source/reg_service.dart';
import 'package:dio/dio.dart'as dio;
class RegRepositoryImpl extends RegRepository {
  RegRepositoryImpl(RegService loginService) : super(loginService);

  @override
  Future<Response<RegistrationModel?>?> regPass(dio.FormData data) async {
    Response<RegistrationModel>? apiResponse;
    apiResponse = await regService.regPass(data);
    return apiResponse;
  }

}
