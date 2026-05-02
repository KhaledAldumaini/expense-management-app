import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text("Are you sure you want to delete this expense?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: const Text("Delete", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
