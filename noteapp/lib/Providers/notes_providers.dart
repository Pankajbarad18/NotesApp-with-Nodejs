import 'package:flutter/material.dart';
import 'package:noteapp/Models/Notes.dart';
import 'package:noteapp/Services/Service.dart';

class NotesProviders with ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = true;

  NotesProviders() {
    fetchData();
  }
  void sortData() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  List<Note> searchedData(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void addNotes(Note note) {
    notes.add(note);
    sortData();
    notifyListeners();
    ApiService.addAPIData(note);
  }

  void updateNotes(Note note) {
    int index =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[index] = note;
    sortData();
    notifyListeners();
    ApiService.addAPIData(note);
  }

  void deleteNotes(Note note) {
    int index =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(index);
    sortData();
    notifyListeners();
    ApiService.deleteAPIData(note);
  }

  void fetchData() async {
    notes = await ApiService.fetchAPIData("Pankaj");
    sortData();
    isLoading = false;
    notifyListeners();
  }
}
