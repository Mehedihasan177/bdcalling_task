import '../repository/get_all_task_list_repository.dart';

abstract class GetAllTaskListModelListUseCase {
  final GetAllTaskListModelListRepository getAllTaskListModelListRepository;

  GetAllTaskListModelListUseCase(this.getAllTaskListModelListRepository);
}

abstract class DeleteTaskModelUseCase {
  final GetAllTaskListModelListRepository getAllTaskListModelListRepository;

  DeleteTaskModelUseCase(this.getAllTaskListModelListRepository);
}
abstract class GetTaskDetailsModelUseCase {
  final GetAllTaskListModelListRepository getAllTaskListModelListRepository;

  GetTaskDetailsModelUseCase(this.getAllTaskListModelListRepository);
}

abstract class CreateTaskModelUseCase {
  final GetAllTaskListModelListRepository getAllTaskListModelListRepository;

  CreateTaskModelUseCase(this.getAllTaskListModelListRepository);
}

