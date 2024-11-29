

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/active_user_model.dart';
import '../../data/source/active_user_service.dart';

abstract class ActiveUserRepository {
  final ActiveUserService loginService;

  ActiveUserRepository(this.loginService);

  Future<Response<ActiveUserModel?>?> loginWithIdPass(
      {required String email, required String code});
}
