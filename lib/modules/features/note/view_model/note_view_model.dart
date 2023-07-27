import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteViewModel extends ChangeNotifier {
  bool isloading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


 void addDataToFirebase(String notes) {
  DateTime currentDateTime = DateTime.now().toLocal();
  int currentTimeStamp = currentDateTime.millisecondsSinceEpoch;
  isloading = true;
  notifyListeners();
  try {
    CollectionReference usersRef = _firestore.collection('notelist');

    // Data to be added
    Map<String, dynamic> userData = {
      'notes': notes,
      'created_date': currentTimeStamp
    };

    // Use the add() method to add data with an auto-generated ID
    usersRef.add(userData).then((value) {
      // Retrieve the auto-generated ID of the added document
      String noteId = value.id;
      print('Data added successfully with ID: $noteId');

      // Update the userData map with the note ID
      userData['note_id'] = noteId;

      // Now you can do any additional processing with the userData, including
      // updating the Firestore document with the note ID if needed.

      // Example: Updating the document with the note ID
      usersRef.doc(noteId).update({'note_id': noteId}).then((_) {
        print('Note ID added to the document');
      }).catchError((error) {
        print('Failed to add note ID to the document: $error');
      });

    }).catchError((error) {
      print('Failed to add data: $error');
    });
  } catch (e) {
    print('Error: $e');
  }
  isloading = false;
  notifyListeners();
}

}
