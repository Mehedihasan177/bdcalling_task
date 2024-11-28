import '../repository/reg_repository.dart';

abstract class RegUseCase {
  final RegRepository regRepository;

  RegUseCase(this.regRepository);
}

