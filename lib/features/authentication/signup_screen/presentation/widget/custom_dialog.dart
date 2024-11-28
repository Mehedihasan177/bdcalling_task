import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String headingText;
  final String secondaryText;

  const CustomDialog({
    Key? key,
    required this.headingText,
    required this.secondaryText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: size.height * 0.8,
        width: size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              headingText,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(height: 8.0),
            Text(
              secondaryText,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(height: 16.0),
            Container(
              height: size.height * 0.6,
              width: size.width * 0.8,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
