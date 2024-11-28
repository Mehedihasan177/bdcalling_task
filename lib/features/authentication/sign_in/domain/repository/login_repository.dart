

import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/login_model.dart';
import '../../data/model/user_info_model.dart';
import '../../data/source/login_service.dart';

abstract class SignInRepository {
  final SignInService loginService;

  SignInRepository(this.loginService);

  Future<Response<LoginModel?>?> loginWithIdPass(
      {required String userName, required String password});
}
