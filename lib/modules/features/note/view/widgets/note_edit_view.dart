import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/common/constant/app_dimens.dart';
import 'package:notes_app/theme/app_theme.dart';

class NoteEditPage extends StatefulWidget {
  final String noteText;
  final String noteId;

  NoteEditPage({required this.noteText, required this.noteId});

  @override
  _NoteEditPageState createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.noteText;
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDateTime = DateTime.now().toLocal();
    int currentTimeStamp = currentDateTime.millisecondsSinceEpoch;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 12),
            child: InkWell(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('notelist')
                    .doc(widget.noteId)
                    .update({
                  'notes': textEditingController.text,
                  'created_date': currentTimeStamp
                }).then((value) {
                  Navigator.pop(context);
                }).catchError((error) {
                  // Handle error
                  print('Error updating note: $error');
                });
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
        child: TextField(
          controller: textEditingController,
          cursorColor: primaryColor,
          cursorHeight: 30,
          maxLines: null,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
