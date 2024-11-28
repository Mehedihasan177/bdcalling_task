import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app_project/features/todo_details/data/repository_implement/todo_repository_implement.dart';
import 'package:todo_app_project/features/todo_details/data/services/todo_services.dart';
import 'package:todo_app_project/features/todo_details/domain/repository/todo_repository.dart';

import '../../features/authentication/sign_in/data/repository/login_repository_impl.dart';
import '../../features/authentication/sign_in/data/source/login_service.dart';
import '../../features/authentication/sign_in/domain/repository/login_repository.dart';
import '../../features/authentication/sign_in/presentation/controller/signin_controller.dart';
import '../../features/authentication/signup_screen/data/repository/reg_repository_impl.dart';
import '../../features/authentication/signup_screen/data/source/reg_service.dart';
import '../../features/authentication/signup_screen/domain/repository/reg_repository.dart';
import '../../features/authentication/signup_screen/presentation/controller/signup_controller.dart';




final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<ToDoDetailsServices>(() => ToDoDetailsServices());
  locator.registerFactory<ToDoDetailsRepository>(() => ToDoDetailsRepositoryImplement(locator()));
  //login
  locator.registerFactory<SigninController>(() => Get.put(SigninController()));
  locator.registerFactory<SignInService>(() => SignInService());
  locator.registerFactory<SignInRepository>(
          () => SignInRepositoryImpl(locator<SignInService>()));
  //sign up
  locator.registerFactory<SignupController>(() => Get.put(SignupController()));
  locator.registerFactory<RegService>(() => RegService());
  locator.registerFactory<RegRepository>(
          () => RegRepositoryImpl(locator<RegService>()));
}