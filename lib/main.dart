import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/app/app_routes.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/modules/features/note/view_model/note_view_model.dart';
import 'package:notes_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(create: (_)=>NoteViewModel(),child:  MaterialApp(
      theme: AppThemes.light,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.note,
      onGenerateRoute: AppRoutes.generateRoute,
    ) ,)
  
  );
}
