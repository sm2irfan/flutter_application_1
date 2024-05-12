import 'package:flutter/material.dart';

class QuestionDescription extends StatelessWidget {
  final String descriptionText;

  const QuestionDescription({super.key, required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // adjust the padding as needed
        child: Text(descriptionText),
      ),
      // child: Text(quesTitle),
    );
  }
}

// if you want to use decoration box then use this 
// decoration property is not recognized in the SizedBox widget
// Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 40,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: Colors.blue,
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0), // adjust the padding as needed
//         child: Text(quesTitle),
//       ),
//       // child: Text(quesTitle),
//     );
//   }
