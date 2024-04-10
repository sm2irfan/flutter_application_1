import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String answerPlace;
  final String answerText;
  final Color color;
  final VoidCallback onTap;

  const AnswerOption({super.key, 
    required this.answerPlace,
    required this.answerText,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.blue, width: 1),
        ),
        child: ListTile(
          title: Text(
            answerText,
            style: const TextStyle(color: Colors.black),
          ),
          leading: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                answerPlace,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
