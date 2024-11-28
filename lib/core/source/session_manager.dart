
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/authentication/sign_in/data/model/login_model.dart';

class SessionManager {
  final box = GetStorage();
  Future<bool> createSession(LoginModel? loginModelData, {String? phoneNumber,  String? password}) async {
    print("this is session ${loginModelData?.data?.user?.email}");
    try {
        box.write("token", loginModelData?.data?.token);
        box.write("password", password);
        box.write("address", loginModelData?.data?.user?.address);
        box.write("activationCode", loginModelData?.data?.user?.activationCode);
        box.write("id", loginModelData?.data?.user?.sId);
        box.write("photo", loginModelData?.data?.user?.image);
        box.write("email",loginModelData?.data?.user?.email);
      return true;
    } catch (e) {
      return false;
    }
  }
}
