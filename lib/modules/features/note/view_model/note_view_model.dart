import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteViewModel extends ChangeNotifier {
  bool isloading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addDataToFirebase(String notes) {
    isloading = true;
    notifyListeners();
    try {
      CollectionReference usersRef = _firestore.collection('notelist');

      // Data to be added
      Map<String, dynamic> userData = {
        'notes': notes,
      };

      // Use the add() method to add data with an auto-generated ID
      usersRef.add(userData).then((value) {
        print('Data added successfully with ID: ${value.id}');
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
