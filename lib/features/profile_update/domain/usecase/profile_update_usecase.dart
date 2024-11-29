import '../repository/profile_update_repository.dart';

abstract class ProfileUpdateUseCase {
  final ProfileUpdateRepository profileUpdateRepository;

  ProfileUpdateUseCase(this.profileUpdateRepository);
}

abstract class ProfileModelUseCase {
  final ProfileUpdateRepository profileUpdateRepository;

  ProfileModelUseCase(this.profileUpdateRepository);
}

