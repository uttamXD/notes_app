import 'package:flutter/material.dart';
import 'package:notes_app/modules/features/note/view/note_view.dart';
import 'package:notes_app/modules/features/note/view/widgets/create_note.dart';
import 'package:notes_app/modules/features/note/view/widgets/note_edit_view.dart';

class AppRoutes {
  static const String note = '/note';
  static const String createNote = '/create-note';
  static const String editNote = '/edit-note';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case note:
        return MaterialPageRoute(
          builder: (_) => const NoteView(),
        );

      case editNote:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => NoteEditView(
            noteId: args['noteid'],
            noteText: args['noteText'],
          ),
        );

      case createNote:
        return MaterialPageRoute(builder: (_) => const CreateNotesView());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Error: Route not found!'),
            ),
          ),
        );
    }
  }
}
