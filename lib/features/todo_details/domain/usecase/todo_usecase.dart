import '../repository/todo_repository.dart';

abstract class ToDoDetailsUseCase {
  final ToDoDetailsRepository toDoRepository;

  ToDoDetailsUseCase(this.toDoRepository);
}