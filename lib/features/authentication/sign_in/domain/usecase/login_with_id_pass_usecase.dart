
import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/login_model.dart';
import '../../data/model/user_info_model.dart';
import 'login_usecase.dart';

class LoginWithIdPassUseCase extends LoginUseCase {
  LoginWithIdPassUseCase(super.loginRepository);

  Future<Response<LoginModel?>?> call(
      {required String userName, required String password}) async {
    var response = await loginRepository.loginWithIdPass(
        userName: userName, password: password);
    return response;
  }
}
