import 'package:flutter/material.dart';
import 'package:movie_search_app/config/palette.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({Key? key, required this.buttonHandler})
      : super(key: key);

  final VoidCallback buttonHandler;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.only(left: 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: buttonHandler,
            child: Text("Register Now",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Palette.kToDark,
                )))
      ],
    ));
  }
}
