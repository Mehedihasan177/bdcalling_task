// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:todo_app_project/core/routes/router.dart';
import 'package:todo_app_project/core/services/theme_services.dart';

import 'core/app_component/app_component.dart';
import 'core/source/session_manager.dart';
import 'features/get_all_task/presentation/ui/theme.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final session = SessionManager();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await init();
  await Firebase.initializeApp();
  runApp(const MyApp());

}
final box = GetStorage();
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeServices _ts = ThemeServices();


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Management',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: _ts.theme,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: RouteGenerator.onRouteGenerate,
    );
  }
}

