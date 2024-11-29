import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/acitve_user/data/repository/active_user_repository_impl.dart';
import '../../features/authentication/acitve_user/data/source/active_user_service.dart';
import '../../features/authentication/acitve_user/domain/repository/active_user_repository.dart';
import '../../features/authentication/acitve_user/presentation/controller/active_user_controller.dart';
import '../../features/authentication/sign_in/data/repository/login_repository_impl.dart';
import '../../features/authentication/sign_in/data/source/login_service.dart';
import '../../features/authentication/sign_in/domain/repository/login_repository.dart';
import '../../features/authentication/sign_in/presentation/controller/signin_controller.dart';
import '../../features/authentication/signup_screen/data/repository/reg_repository_impl.dart';
import '../../features/authentication/signup_screen/data/source/reg_service.dart';
import '../../features/authentication/signup_screen/domain/repository/reg_repository.dart';
import '../../features/authentication/signup_screen/presentation/controller/signup_controller.dart';
import '../../features/get_all_task/data/repository/get_all_task_list_repository_impl.dart';
import '../../features/get_all_task/data/source/get_all_task_list_service.dart';
import '../../features/get_all_task/domain/repository/get_all_task_list_repository.dart';
import '../../features/get_all_task/presentation/controller/task_controller.dart';
import '../../features/profile_update/data/repository/profile_update_repository_impl.dart';
import '../../features/profile_update/data/source/profile_update_service.dart';
import '../../features/profile_update/domain/repository/profile_update_repository.dart';
import '../../features/profile_update/presentation/controller/profile_update_controller.dart';
import '../source/dio_client.dart';




final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<Dio>(
          () => Dio()..interceptors.add(InterceptorsWrapper()));
  locator.registerFactory<DioClient>(() => DioClient(locator<Dio>()));


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
  //active user
  locator.registerFactory<ActiveUserController>(() => Get.put(ActiveUserController()));
  locator.registerFactory<ActiveUserService>(() => ActiveUserService());
  locator.registerFactory<ActiveUserRepository>(
          () => ActiveUserRepositoryImpl(locator<ActiveUserService>()));
  //task
  locator.registerFactory<TaskController>(() => Get.put(TaskController()));
  locator.registerFactory<GetAllTaskListModelListService>(() => GetAllTaskListModelListService());
  locator.registerFactory<GetAllTaskListModelListRepository>(
          () => GetAllTaskListModelListRepositoryImpl(locator<GetAllTaskListModelListService>()));
  //profile
  locator.registerFactory<ProfileUpdateController>(() => Get.put(ProfileUpdateController()));
  locator.registerFactory<ProfileUpdateService>(() => ProfileUpdateService());
  locator.registerFactory<ProfileUpdateRepository>(
          () => ProfileUpdateRepositoryImpl(locator<ProfileUpdateService>()));

}