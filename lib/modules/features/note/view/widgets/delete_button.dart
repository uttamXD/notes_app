import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/theme/app_theme.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  final String noteId;

  const DeleteButton(
      {super.key, required this.onPressed, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseFirestore.instance
            .collection('/notelist')
            .doc(noteId)
            .delete();
      },
      style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
      child: const Icon(Icons.delete),
    );
  }
}
