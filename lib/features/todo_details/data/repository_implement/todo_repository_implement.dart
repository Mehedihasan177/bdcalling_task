import '../../../../../../../core/data/model/api_response.dart';
// import '../../domain/repository/course_repository.dart';
import '../../domain/repository/todo_repository.dart';

import '../model/todo_model.dart';
import '../services/todo_services.dart';

class ToDoDetailsRepositoryImplement extends ToDoDetailsRepository {
  ToDoDetailsRepositoryImplement(ToDoDetailsServices fetchDataServices)
      : super(fetchDataServices);

  @override
  Future<Response<List<TodoList>?>> fetchDataPass() async {
    return fetchDataServices.fetchData();
  }
  @override
  Future<Future<TodoList?>> addTodoList({required String title, required String note, required String date, required String startTime, required String endTime}) async {
    return fetchDataServices.addTodoList(title: title, note: note, date: date, startTime: startTime, endTime: endTime);
  }
  @override
  Future<Future<TodoList?>> deleteTodoItem({required String documentId}) async {
    return fetchDataServices.deleteTodoItem(documentId: documentId);
  }
  @override
  Future<Future<TodoList?>> completeTodoItem({required String documentId}) async {
    return fetchDataServices.completeTodoItem(documentId: documentId);
  }
  @override
  Future<Future<TodoList?>> deleteCollectionAndReturnItem() async {
    return fetchDataServices.deleteCollectionAndReturnItem();
  }
}