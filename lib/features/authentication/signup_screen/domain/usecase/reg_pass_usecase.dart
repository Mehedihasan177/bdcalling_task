
import 'package:dio/dio.dart'as dio;

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/registration_model.dart';
import 'reg_usecase.dart';

class RegPassUseCase extends RegUseCase {
  RegPassUseCase(super.regRepository);

  Future<Response<RegistrationModel?>?> call(dio.FormData data) async {
    var response = await regRepository.regPass(data);
    return response;
  }
}

