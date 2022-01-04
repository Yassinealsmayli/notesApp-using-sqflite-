import 'package:flutter/material.dart';
import 'package:sql_database_example/db/notes_db.dart';
import 'package:sql_database_example/model/note.dart';
import 'package:sql_database_example/pages/note_page.dart';

import '../constants.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  bool isImportant = false;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _notePage();
  }

  Widget _notePage() => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isImportant = !isImportant;
                  });
                },
                icon: Icon(
                  Icons.star,
                  color: isImportant ? Colors.yellow : Colors.grey,
                )),
            IconButton(
                onPressed: () async {
                  Note note = await NotesDatabases.instance.create(Note(
                      isImportant: isImportant,
                      title: title.text,
                      description: description.text,
                      createdTime: DateTime.now()));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => NotePage(note.id),
                  ));
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                const Text("title:",
                    style: TextStyle(fontSize: defaultPadding)),
                const SizedBox(
                  height: defaultPadding / 2,
                ),
                TextFormField(
                  controller: title,
                  maxLength: 1,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                const Text("description:",
                    style: TextStyle(fontSize: defaultPadding)),
                const SizedBox(
                  height: defaultPadding / 2,
                ),
                Expanded(
                  child: TextFormField(
                    controller: description,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            )),
      );
}
