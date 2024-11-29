
import '../../../../../../core/source/model/api_response.dart';
import '../../data/model/active_user_model.dart';
import 'active_user_usecase.dart';

class ActiveUserPassUseCase extends ActiveUserUseCase {
  ActiveUserPassUseCase(super.activeUserRepository);

  Future<Response<ActiveUserModel?>?> call(
      {required String email, required String code}) async {
    var response = await activeUserRepository.loginWithIdPass(
        email: email, code: code);
    return response;
  }
}
