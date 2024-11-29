import 'package:flutter/material.dart';
import 'package:todo_app_project/core/routes/route_name.dart';
import 'package:todo_app_project/features/authentication/acitve_user/presentation/view/active_user_screen.dart';
import 'package:todo_app_project/features/authentication/sign_in/presentation/view/sign_in_page.dart';
import 'package:todo_app_project/features/authentication/signup_screen/presentation/view/signup_screen.dart';
import 'package:todo_app_project/features/splash_screen/presentation/splash_screen.dart';

import '../../features/get_all_task/presentation/ui/screens/get_task_details_screen.dart';
import '../../features/get_all_task/presentation/ui/screens/home_screen.dart';
import '../../features/profile_update/presentation/view/profile_update_screen.dart';

class RouteGenerator {
  static pushNamed(BuildContext context, String pageName) {
    return Navigator.pushNamed(context, pageName);
  }
  static pushReplacement(BuildContext context, String pageName) {
    return Navigator.of(context).pushReplacementNamed(pageName);
  }
  static pushNamedAndRemoveAll(BuildContext context, String pageName) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(pageName, (Route<dynamic> route) => false);
  }
  static pushNamedWithArguments(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushNamed(context, pageName, arguments: arguments);
  }

  static pushNamedforAdvanceSearch(
      BuildContext context, String pageName, Function filterActionEvent) {
    return Navigator.of(context).pushNamed(pageName);
  }


  static pushReplacementNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushReplacementNamed(context, pageName,
        arguments: arguments);
  }

  static pop(BuildContext context) {
    return Navigator.of(context).pop();
  }
  static popAndPushNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.popAndPushNamed(context, pageName, arguments: arguments);
  }

  static popAll(BuildContext context) {
    return Navigator.of(context).popUntil((route) => false);
  }

  static popUntil(BuildContext context, String pageName) {
    return Navigator.of(context).popUntil(ModalRoute.withName(pageName));
  }

  // ================================== Routing =============================================

  static Route<dynamic>? onRouteGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.homepage:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
        case Routes.signinPage:
        return MaterialPageRoute(
          builder: (context) =>  SignInPage(),
        );
        case Routes.signupPage:
        return MaterialPageRoute(
          builder: (context) =>  SignupScreen(),
        );
        case Routes.activeUserPage:
        return MaterialPageRoute(
          builder: (context) =>  ActiveUserScreen(),
        );
        case Routes.getTaskDetails:
        return MaterialPageRoute(
          builder: (context) =>  GetTaskDetailsScreen(),
        );
        case Routes.profile:
        return MaterialPageRoute(
          builder: (context) =>  ProfileUpdateScreen(),
        );
     
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
   
  }
}
