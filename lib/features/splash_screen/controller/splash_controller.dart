import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';
import '../../../../../main.dart';
import '../../../core/app_component/app_component.dart';
import '../../authentication/sign_in/presentation/controller/signin_controller.dart';
import '../../widget/custom_toast/custom_toast.dart';

class SplashScreenController extends GetxController{
var signInController = locator<SigninController>();
  @override
  void onInit() {
    checkApplicationInformation();
    super.onInit();
  }

void checkApplicationInformation()async{

  Future.delayed(const Duration(seconds: 3), () async {
    print("the value2222 ${box.read("email")} ${box.read("password")}");
  if((box.read("email")?.toString().isNotEmpty ?? false) && (box.read("password")?.toString().isNotEmpty ?? false)){
    signInController.submitLoginData(navigatorKey.currentContext!, from: "splash");
  }else{
      RouteGenerator.pushNamedAndRemoveAll(
          navigatorKey.currentContext!, Routes.signinPage);
      box.erase();
  }
  });
}
}