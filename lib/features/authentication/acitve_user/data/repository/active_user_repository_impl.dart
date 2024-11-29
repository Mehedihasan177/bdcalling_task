import '../../../../../../core/source/model/api_response.dart';
import '../../domain/repository/active_user_repository.dart';
import '../model/active_user_model.dart';
import '../source/active_user_service.dart';

class ActiveUserRepositoryImpl extends ActiveUserRepository {
  ActiveUserRepositoryImpl(ActiveUserService loginService) : super(loginService);

  @override
  Future<Response<ActiveUserModel?>?> loginWithIdPass(
      {required String email, required String code}) async {
    Response<ActiveUserModel>? apiResponse;
    apiResponse = await loginService.loginWithIdPass(email, code);
    return apiResponse;
  }

}
