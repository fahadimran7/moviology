import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Expanded(
          child: Divider(
            indent: 20.0,
            endIndent: 10.0,
            thickness: 1,
          ),
        ),
        Text(
          "OR",
          style: TextStyle(color: Colors.blueGrey),
        ),
        Expanded(
          child: Divider(
            indent: 10.0,
            endIndent: 20.0,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
