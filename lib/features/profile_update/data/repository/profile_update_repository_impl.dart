
import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/profile_update_repository.dart';
import '../model/profile_model.dart';
import '../model/profile_update_model.dart';
import '../source/profile_update_service.dart';
import 'package:dio/dio.dart'as dio;
class ProfileUpdateRepositoryImpl extends ProfileUpdateRepository {
  ProfileUpdateRepositoryImpl(ProfileUpdateService profileUpdateService) : super(profileUpdateService);

  @override
  Future<Response<ProfileUpdateModel?>?> profileUpdatePass(dio.FormData data) async {
    Response<ProfileUpdateModel>? apiResponse;
    apiResponse = await profileUpdateService.profileUpdatePass(data);
    return apiResponse;
  }
  @override
  Future<Response<ProfileModel?>?> profile() async {
    Response<ProfileModel>? apiResponse;
    apiResponse = await profileUpdateService.profile();
    return apiResponse;
  }

}
