import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/common/constant/app_dimens.dart';
import 'package:notes_app/common/constant/ui_helpers.dart';
import 'package:notes_app/common/widget/k_textformfield.dart';
import 'package:notes_app/core/app/app_routes.dart';
import 'package:notes_app/modules/features/note/view/widgets/note_edit_view.dart';
import 'package:notes_app/theme/app_theme.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController();
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
              const KTextFormField(
                hint: "Search",
                prefixIcon: Icon(
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
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.editNote,
                                arguments: {
                                  'noteid': noteid,
                                  'noteText': note,
                                });
                                

                           
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Card(
                                  color: secondaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(note),
                                  ),
                                ),
                              ),
                              Text(createdData),
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
                  title: Text(
                    "12 notes",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
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
