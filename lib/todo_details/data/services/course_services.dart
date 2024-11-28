// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_project/core/data/model/api_response.dart';

import '../../../features/todo_details/data/model/todo_model.dart';

class ToDoDetailsServices {
  final FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

  Future<Response<List<TodoList>?>> fetchData() async {
    List<TodoList>? dataList;
    Response<List<TodoList>?> apiResponse;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseStore.collection('todoList').get();

      dataList = querySnapshot.docs
          .map((doc) {
          return TodoList.fromJson(doc.data());
          } )
          .where((todoList) => todoList != null) // Remove null entries
          .toList();
      apiResponse = Response.success(dataList);
    } catch (error) {
      apiResponse = Response.error("Error loading data from Firestore", 500);
    }

    return apiResponse;
  }

Future<TodoList?> addTodoList({required String title, required String note, required String date, required String startTime, required String endTime}) async {
  try {
    CollectionReference<Map<String, dynamic>> courseDetailsCollection =
        FirebaseFirestore.instance.collection('todoList');

    DocumentReference<Map<String, dynamic>> docRef =
        await courseDetailsCollection.add({
      'title': title,
      'note': note,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'isComplete': false,
    });
await docRef.update({'id': docRef.id});
    
fetchData();
    // Retrieve the added document from Firestore using the DocumentReference
    DocumentSnapshot<Map<String, dynamic>> addedDoc = await docRef.get();

    // Convert the added document data to a TodoList object
    return TodoList.fromJson(addedDoc.data() ?? {});
  } catch (error) {
    return null;
  }
}


Future<TodoList?> deleteTodoItem({required String documentId}) async {
  try {
    CollectionReference<Map<String, dynamic>> todoCollection =
        FirebaseFirestore.instance.collection('todoList');

    // Reference to the specific document you want to delete
    DocumentReference<Map<String, dynamic>> documentReference =
        todoCollection.doc(documentId);

    // Delete the document
    await documentReference.delete();
DocumentSnapshot<Map<String, dynamic>> addedDoc = await documentReference.get();
      return TodoList.fromJson(addedDoc.data() ?? {});
  } catch (error) {
    return null;
  }
}
Future<TodoList?> completeTodoItem({required String documentId}) async {
   if (documentId.isEmpty) {
      return null;
    }
  try {
    CollectionReference<Map<String, dynamic>> todoCollection =
        FirebaseFirestore.instance.collection('todoList');

    // Reference to the specific document you want to update
    DocumentReference<Map<String, dynamic>> documentReference =
        todoCollection.doc(documentId);
Map<String, dynamic> updatedData = {
  'isComplete': true,
  // Add other fields you want to update
};

    // Update the document
    await documentReference.update(updatedData);

    // Retrieve the updated document from Firestore
    DocumentSnapshot<Map<String, dynamic>> updatedDoc = await documentReference.get();

    // Return the TodoList instance representing the updated document
    return TodoList.fromJson(updatedDoc.data() ?? {});
  } catch (error) {
    return null;
  }
}


Future<TodoList?> deleteCollectionAndReturnItem() async {
  try {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('todoList');

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionReference.get();

    TodoList? deletedTodo;

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot in querySnapshot.docs) {
      // Capture the data of a specific document before deleting the collection
      // if (documentSnapshot.data()?['id'] == 'your_criteria') {
        deletedTodo = TodoList.fromJson(documentSnapshot.data());
      // }

      await documentSnapshot.reference.delete();
    }

    
    // Return TodoList instance based on the criteria
    return deletedTodo;
  } catch (error) {
    return null;
  }
}

}
