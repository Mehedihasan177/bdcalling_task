

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/profile_model.dart';
import '../../data/model/profile_update_model.dart';
import '../../data/source/profile_update_service.dart';
import 'package:dio/dio.dart'as dio;
abstract class ProfileUpdateRepository {
  final ProfileUpdateService profileUpdateService;

  ProfileUpdateRepository(this.profileUpdateService);

  Future<Response<ProfileUpdateModel?>?> profileUpdatePass(dio.FormData data);
  Future<Response<ProfileModel?>?> profile();
}
