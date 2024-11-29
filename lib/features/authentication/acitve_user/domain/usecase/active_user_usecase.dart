import '../repository/active_user_repository.dart';

abstract class ActiveUserUseCase {
  final ActiveUserRepository activeUserRepository;

  ActiveUserUseCase(this.activeUserRepository);
}

