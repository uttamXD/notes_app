import 'package:flutter/material.dart';
import 'package:notes_app/common/constant/app_dimens.dart';
import 'package:notes_app/modules/features/note/view_model/note_view_model.dart';
import 'package:notes_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widget/k_textformfield.dart';

class CreateNotesView extends StatefulWidget {
  const CreateNotesView({
    super.key,
  });

  @override
  State<CreateNotesView> createState() => _CreateNotesViewState();
}

class _CreateNotesViewState extends State<CreateNotesView> {
  @override
  void initState() {
    Provider.of<NoteViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController createNoteController = TextEditingController();
    final noteData = Provider.of<NoteViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 12),
            child: InkWell(
              onTap: () {
                noteData.addDataToFirebase(createNoteController.text);
                Navigator.pop(context);
              },
              child: Text(
                "Done",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: primaryColor, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
        title: Text(
          "Notes",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: primaryColor, fontWeight: FontWeight.normal),
        ),
      ),
      body: Padding(
        padding: AppDimens.mainPagePadding,
        child: KTextFormField(
            autoFocus: true,
            controller: createNoteController,
            cursorColor: primaryColor,
            cursorHeight: 30,
            focusColor: Colors.transparent,
          )
      ),
    );
  }
}
