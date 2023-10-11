// ignore_for_file: file_names

import 'dart:convert';
import 'package:noteapp/Models/Notes.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseURL =
      "https://secure-sierra-96707-c79d4a93fde0.herokuapp.com/notes";

  static Future<void> addAPIData(Note note) async {
    Uri requestUri = Uri.parse("$_baseURL/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<void> deleteAPIData(Note note) async {
    Uri requestUri = Uri.parse("$_baseURL/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<List<Note>> fetchAPIData(String userid) async {
    Uri requestUri = Uri.parse("$_baseURL/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);
    List<Note> note = [];

    for (var notes in decoded) {
      Note newNote = Note.fromMap(notes);
      note.add(newNote);
    }

    return note;
  }
}
