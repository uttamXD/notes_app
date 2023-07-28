import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/common/constant/app_dimens.dart';
import 'package:notes_app/common/constant/ui_helpers.dart';
import 'package:notes_app/common/widget/k_textformfield.dart';
import 'package:notes_app/core/app/app_routes.dart';
import 'package:notes_app/modules/features/note/view_model/note_view_model.dart';
import 'package:notes_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<NoteViewModel>(context);

    kShowBottomSheet(String noteid) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: errorColor,
                ),
                title: const Text('Delete note'),
                onTap: () {
                  states.deleteNoteFromFirebase(noteid);

                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppDimens.mainPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: AppDimens.headlineFontSizeMedium),
              ),
              sHeightSpan,
              KTextFormField(
                cursorColor: primaryColor,
                hintText: "Search",
                focusColor: disabledColor,
                prefixIcon: const Icon(
                  Icons.search,
                  color: disabledColor,
                ),
              ),
              mHeightSpan,
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('notelist')
                      .snapshots(),
                  builder: (context, snapshot) {
                    final data = snapshot.data?.docs;

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Error fetching data'));
                    }

                    return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        String note = data?[index]['notes'];
                        String noteid = data?[index]['note_id'];
                        String createdData =
                            data?[index]['created_date'].toString() ?? '';

                        return GestureDetector(
                          onLongPress: () {
                            kShowBottomSheet(noteid);
                          },
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.editNote,
                              arguments: {
                                'noteid': noteid,
                                'noteText': note,
                              },
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                states.formatTimeAgoFromTimestamp(
                                  int.parse(createdData),
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Card(
                                  color: secondaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      note,
                                    ),
                                  ),
                                ),
                              ),
                              mHeightSpan,
                              sHeightSpan,
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              sHeightSpan,
              Container(
                color: secondaryColor,
                child: ListTile(
                  trailing: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.createNote);
                    },
                    child: Icon(
                      Icons.edit_calendar_rounded,
                      color: primaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
