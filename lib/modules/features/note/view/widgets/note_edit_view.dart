import 'package:flutter/material.dart';
import 'package:notes_app/common/constant/app_dimens.dart';
import 'package:notes_app/common/widget/k_textformfield.dart';
import 'package:notes_app/modules/features/note/view_model/note_view_model.dart';
import 'package:notes_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class NoteEditView extends StatefulWidget {
  final String noteText;
  final String noteId;

  const NoteEditView({super.key, required this.noteText, required this.noteId});

  @override
  _NoteEditViewState createState() => _NoteEditViewState();
}

class _NoteEditViewState extends State<NoteEditView> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.noteText;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<NoteViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 12),
            child: InkWell(
              onTap: () {
                state.editNoteFromFirebase(
                    widget.noteId, textEditingController.text, context);
                textEditingController.clear();
                FocusScope.of(context).unfocus();
              },
              child: Text(
                "Done",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: primaryColor, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: AppDimens.mainPagePadding,
          child: KTextFormField(
            autoFocus: true,
            controller: textEditingController,
            cursorColor: primaryColor,
            cursorHeight: 30,
            focusColor: Colors.transparent,
          )),
    );
  }
}
