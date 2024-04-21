import 'package:flutter/material.dart';


class QuestionTitle extends StatelessWidget {
  final String quesTitle;

  const QuestionTitle({super.key, required this.quesTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 40,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   border: Border.all(
      //     color: Colors.blue,
      //     width: 2,
      //   ),
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // adjust the padding as needed
        child: Text(quesTitle),
      ),
      // child: Text(quesTitle),
    );
  }
}
