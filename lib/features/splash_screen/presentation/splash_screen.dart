
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_project/core/routes/router.dart';
import 'package:todo_app_project/features/splash_screen/controller/splash_controller.dart';

import '../../../core/routes/route_name.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   Future.delayed(const Duration(seconds: 2),(){
  //           RouteGenerator.pushNamedAndRemoveAll(context, Routes.homepage);
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Expanded(
                  flex: 9,
                  child: Center(
                    child: Image.asset("images/logo.png", height: 200, width:  200,),
                  ),
                ),
                const Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      }
    );
  }
}
