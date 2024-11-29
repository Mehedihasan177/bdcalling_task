
import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/login_model.dart';
import 'login_usecase.dart';

class SignInPassUseCase extends SignInUseCase {
  SignInPassUseCase(super.loginRepository);

  Future<Response<LoginModel?>?> call(
      {required String email, required String password}) async {
    var response = await loginRepository.loginWithIdPass(
        email: email, password: password);
    return response;
  }
}
