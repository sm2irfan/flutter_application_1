import 'package:flutter/material.dart';

class ExamPaper extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;
  final VoidCallback onEditPressed;
  final VoidCallback onResetPressed;

  const ExamPaper({
    required this.buttonText,
    required this.onPressed,
    required this.isLoading,
    required this.onEditPressed,
    required this.onResetPressed,

    super.key,
  });

  @override
  State<ExamPaper> createState() => _ExamPaperState();
}

class _ExamPaperState extends State<ExamPaper> {
  final ValueNotifier<bool> _showMenu = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50), // Green color
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                elevation: 0, // Remove the default elevation
              ),
              child: Text(
                'File Name: ${widget.buttonText}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4), // Add spacing between buttons
          ValueListenableBuilder<bool>(
            valueListenable: _showMenu,
            builder: (context, showMenu, child) {
              return PopupMenuButton(
                tooltip: 'More options',
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'Edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'Reset',
                    child: Text('Reset'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'Edit') {
                    widget.onEditPressed();
                  } else if (value == 'Reset') {
                    widget.onResetPressed();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
