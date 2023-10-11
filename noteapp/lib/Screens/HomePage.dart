// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/Models/Notes.dart';
import 'package:noteapp/Providers/notes_providers.dart';
import 'package:noteapp/Screens/add_note.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String searchQuery = "";

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProviders notesProviders = Provider.of<NotesProviders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note App"),
        centerTitle: true,
      ),
      body: !notesProviders.isLoading
          ? notesProviders.notes.isNotEmpty
              ? ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            searchQuery = val;
                          });
                        },
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    notesProviders.searchedData(searchQuery).isNotEmpty
                        ? GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount:
                                notesProviders.searchedData(searchQuery).length,
                            itemBuilder: (context, index) {
                              Note current =
                                  Provider.of<NotesProviders>(context)
                                      .searchedData(searchQuery)[index];
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              fullscreenDialog: true,
                                              builder: ((context) => AddNewNote(
                                                    isupdate: true,
                                                    note: current,
                                                  ))));
                                    },
                                    onLongPress: () {
                                      Provider.of<NotesProviders>(context,
                                              listen: false)
                                          .deleteNotes(current);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple[200]),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                current.title!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              current.content!,
                                              maxLines: 6,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ]),
                                    ),
                                  ),
                                  Positioned(
                                      top: -3,
                                      left: 85,
                                      child: Image.asset(
                                        "lib/Images/push-pin.png",
                                        width: 25,
                                      ))
                                ],
                              );
                            })
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "No Notes Found",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                  ],
                )
              : const Center(
                  child: Text("No Notes Yet"),
                )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: ((context) => const AddNewNote(
                        isupdate: false,
                      ))));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
