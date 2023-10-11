import 'package:flutter/material.dart';
import 'package:noteapp/Models/Notes.dart';
import 'package:noteapp/Providers/notes_providers.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNote extends StatefulWidget {
  final bool isupdate;
  final Note? note;
  const AddNewNote({super.key, required this.isupdate, this.note});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  FocusNode notefocus = FocusNode();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  void addnewNote() {
    Note newNote = Note(
        id: const Uuid().v1(),
        userid: "Pankaj",
        title: titlecontroller.text,
        content: notecontroller.text,
        dateadded: DateTime.now());

    Provider.of<NotesProviders>(context, listen: false).addNotes(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titlecontroller.text;
    widget.note!.content = notecontroller.text;
    widget.note!.dateadded = DateTime.now();
    Provider.of<NotesProviders>(context, listen: false)
        .updateNotes(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isupdate) {
      titlecontroller.text = widget.note!.title!;
      notecontroller.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (widget.isupdate) {
                updateNote();
              } else {
                addnewNote();
              }
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          children: [
            TextField(
              autofocus: !widget.isupdate,
              controller: titlecontroller,
              onSubmitted: (val) {
                if (val != "") {
                  notefocus.requestFocus();
                }
              },
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                controller: notecontroller,
                focusNode: notefocus,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    hintText: "Note",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
