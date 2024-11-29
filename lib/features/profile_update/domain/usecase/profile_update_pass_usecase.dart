
import 'package:dio/dio.dart'as dio;

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/profile_model.dart';
import '../../data/model/profile_update_model.dart';
import 'profile_update_usecase.dart';

class ProfileUpdatePassUseCase extends ProfileUpdateUseCase {
  ProfileUpdatePassUseCase(super.profileUpdateRepository);

  Future<Response<ProfileUpdateModel?>?> call(dio.FormData data) async {
    var response = await profileUpdateRepository.profileUpdatePass(data);
    return response;
  }
}
class ProfileModelPassUseCase extends ProfileModelUseCase {
  ProfileModelPassUseCase(super.profileUpdateRepository);

  Future<Response<ProfileModel?>?> call() async {
    var response = await profileUpdateRepository.profile();
    return response;
  }
}

