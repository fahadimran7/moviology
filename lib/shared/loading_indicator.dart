import 'package:flutter/material.dart';
import 'package:movie_search_app/constants/styles.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: CircularProgressIndicator(
          color: kcPrimarySwatch[900],
        ),
        alignment: const Alignment(0.0, 0.0),
      ),
    );
  }
}
