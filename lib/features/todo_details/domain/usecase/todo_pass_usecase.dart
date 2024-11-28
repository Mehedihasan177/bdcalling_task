

import '../../../../../../../core/data/model/api_response.dart';
import '../../data/model/todo_model.dart';
import 'todo_usecase.dart';


class ToDoDetailsPassUseCase extends ToDoDetailsUseCase {
  ToDoDetailsPassUseCase(super.toDoRepository);

  Future<Response<List<TodoList>?>> call() async {
    return await toDoRepository.fetchDataPass();
  }
}
class AddToDoListPassUseCase extends ToDoDetailsUseCase {
  AddToDoListPassUseCase(super.toDoRepository);

  Future<Future<TodoList?>> call({required String title, required String note, required String date, required String startTime, required String endTime}) async {
    return await toDoRepository.addTodoList(title: title, note: note, date: date, startTime: startTime, endTime: endTime);
  }
}
class DeleteTodoPassUseCase extends ToDoDetailsUseCase {
  DeleteTodoPassUseCase(super.toDoRepository);

  Future<Future<TodoList?>> call({required String documentId}) async {
    return await toDoRepository.deleteTodoItem(documentId: documentId);
  }
}
class CompleteTodoPassUseCase extends ToDoDetailsUseCase {
  CompleteTodoPassUseCase(super.toDoRepository);

  Future<Future<TodoList?>> call({required String documentId}) async {
    return await toDoRepository.completeTodoItem(documentId: documentId);
  }
}
class DeleteCollectionAndReturnItem extends ToDoDetailsUseCase {
  DeleteCollectionAndReturnItem(super.toDoRepository);

  Future<Future<TodoList?>> call() async {
    return await toDoRepository.deleteCollectionAndReturnItem();
  }
}