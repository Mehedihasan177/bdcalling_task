

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/registration_model.dart';
import '../../data/source/reg_service.dart';
import 'package:dio/dio.dart'as dio;
abstract class RegRepository {
  final RegService regService;

  RegRepository(this.regService);

  Future<Response<RegistrationModel?>?> regPass(dio.FormData data);
}
