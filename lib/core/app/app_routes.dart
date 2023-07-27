import 'package:flutter/material.dart';
import 'package:notes_app/modules/features/note/view/note_view.dart';
import 'package:notes_app/modules/features/note/view/widgets/create_note.dart';
import 'package:notes_app/modules/features/note/view/widgets/note_edit_view.dart';
import 'package:notes_app/modules/features/note/view_model/note_view_model.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static const String note = '/note';
  static const String createNote = '/create-note';
  static const String editNote = '/edit-note';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case note:
        return MaterialPageRoute(builder: (_) => const NoteView());

      case editNote:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => NoteEditPage(
            noteId: args['noteid'],
            noteText: args['noteText'],
          ),
        );

      case createNote:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (_) => NoteViewModel(),
                  child: const CreateNotesView(),
                ));

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
