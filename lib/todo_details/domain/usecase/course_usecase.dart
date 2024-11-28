import 'package:todo_app_project/features/todo_details/domain/repository/todo_repository.dart';


abstract class ToDoDetailsUseCase {
  final ToDoDetailsRepository toDoRepository;

  ToDoDetailsUseCase(this.toDoRepository);
}