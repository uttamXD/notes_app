import 'package:flutter/material.dart';
import 'package:notes_app/common/constant/app_dimens.dart';
import 'package:notes_app/common/constant/ui_helpers.dart';
import 'package:notes_app/common/widget/k_textformfield.dart';
import 'package:notes_app/core/app/app_routes.dart';
import 'package:notes_app/theme/app_theme.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Text("helolo");
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
