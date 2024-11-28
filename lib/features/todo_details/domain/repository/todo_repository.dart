
import '../../../../../../core/data/model/api_response.dart';
import '../../data/model/todo_model.dart';
import '../../data/services/todo_services.dart';

abstract class ToDoDetailsRepository {
  final ToDoDetailsServices fetchDataServices;

  ToDoDetailsRepository(this.fetchDataServices);

  Future<Response<List<TodoList>?>> fetchDataPass();
  Future<Future<TodoList?>> addTodoList({required String title, required String note, required String date, required String startTime, required String endTime});
  Future<Future<TodoList?>> deleteTodoItem({required String documentId});
  Future<Future<TodoList?>> completeTodoItem({required String documentId});
  Future<Future<TodoList?>> deleteCollectionAndReturnItem();
}