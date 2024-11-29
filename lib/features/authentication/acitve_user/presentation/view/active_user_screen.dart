import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app_project/core/core/extensions/extensions.dart';
import '../../../../../../core/core/widget/blur_widget.dart';
import '../../../../../../core/routes/route_name.dart';
import '../../../../../../core/routes/router.dart';
import '../../../../../core/app_component/app_component.dart';
import '../../../../../core/utils/consts/app_assets.dart';
import '../../../../../core/utils/consts/app_colors.dart';
import '../../../../../core/utils/consts/app_sizes.dart';
import '../../../../widget/custom_elevatedButton/custom_eleveted_button.dart';
import '../../../../widget/custom_elevatedButton/custom_text.dart';
import '../../../../widget/custom_textfield/custom_textfield.dart';
import '../controller/active_user_controller.dart';

class ActiveUserScreen extends StatefulWidget {
  ActiveUserScreen({super.key});

  @override
  State<ActiveUserScreen> createState() => _ActiveUserScreenState();
}

class _ActiveUserScreenState extends State<ActiveUserScreen> {
  var controller = locator<ActiveUserController>();

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  Timer? _timer;
  int _remainingTime = 5 * 60; // 5 minutes in seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  // String _formatTime(int totalSeconds) {
  //   final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
  //   final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
  //   return '$minutes:$seconds';
  // }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus(); // Close keyboard on the last field
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Verification'),
        centerTitle: true,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Verification Code',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
             Text(
              'Check you email to activate your account',
              style: TextStyle(fontSize: AppSizes.size14, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            // Text(
            //   'Time Remaining: ${_formatTime(_remainingTime)}',
            //   style: const TextStyle(fontSize: 18, color: Colors.red),
            // ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    onChanged: (value) => _onChanged(value, index),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(text: "Verify", hexColor: AppColors.orange, onPress: (){
              controller.code.value = _controllers.map((controller) => controller.text).join();
              controller.activeUserFunction(context);
            },)
            // ElevatedButton(
            //   onPressed: () {
            //     final code = _controllers.map((controller) => controller.text).join();
            //     // Handle verification logic here
            //     print('Verification code: $code');
            //   },
            //   child: const Text('Verify'),
            // ),
          ],
        ),
      ),
    );
  }
}