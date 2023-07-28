import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteViewModel extends ChangeNotifier {
  bool isloading = false;
  int noteActualCount = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> notes = [];
  DateTime currentDateTime = DateTime.now().toLocal();

  void deleteNoteFromFirebase(String noteid) {
    CollectionReference usersRef = _firestore.collection('notelist');
    usersRef.doc(noteid).delete();
  }

  void editNoteFromFirebase(
      String noteId, String editedNote, BuildContext context) {
    int currentTimeStamp = currentDateTime.millisecondsSinceEpoch;

    FirebaseFirestore.instance.collection('notelist').doc(noteId).update(
        {'notes': editedNote, 'created_date': currentTimeStamp}).then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      print('Error updating note: $error');
    });
  }

 

 



  String formatTimeAgoFromTimestamp(int timestamp) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return 'Today';
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return 'Yesterday';
    }

    int daysDifference = now.difference(dateTime).inDays;
    return '$daysDifference days ago';
  }

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
        'created_date': currentTimeStamp,
        'note_id': ''
      };

      // Use the add() method to add data with an auto-generated ID
      usersRef.add(userData).then((value) {
        // Retrieve the auto-generated ID of the added document
        String noteId = value.id;

        userData['note_id'] = noteId;

        usersRef.doc(noteId).update({'note_id': noteId}).then((_) {
          
          print('Note id added sucessfully');
        }).catchError((error) {
          print('Failed to add id: $error');
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
