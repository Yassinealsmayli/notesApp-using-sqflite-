import 'package:flutter/material.dart';
import 'package:sql_database_example/constants.dart';
import 'package:sql_database_example/db/notes_db.dart';
import 'package:sql_database_example/model/note.dart';

class NotePage extends StatefulWidget {
  final int? id;
  const NotePage(this.id, {Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late Note note;
  bool isLoading = false;
  bool canSave = false;
  bool isImportant = false;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    getNote();
  }

  Future getNote() async {
    setState(() {
      isLoading = true;
    });
    note = await NotesDatabases.instance.readNote(widget.id!);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    title.text = note.title;
    description.text = note.description;
    return isLoading ? const CircularProgressIndicator() : _notePage();
  }

  Widget _notePage() => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    canSave = true;
                    isImportant = !isImportant;
                  });
                },
                icon: Icon(
                  Icons.star,
                  color: isImportant ? Colors.yellow : Colors.grey,
                )),
            IconButton(
                onPressed: canSave
                    ? () {
                        NotesDatabases.instance.update(note.copy(
                            isImportant: isImportant,
                            title: title.text, description: description.text));
                        getNote();
                        canSave = false;
                      }
                    : null,
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
                  onChanged: (_) {
                    canSave = true;
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
                SizedBox(
                  height: defaultPadding,
                  child: Text(
                    "${note.createdTime}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Text("description:",
                    style: TextStyle(fontSize: defaultPadding)),
                const SizedBox(
                  height: defaultPadding / 2,
                ),
                Expanded(
                  child: TextFormField(
                    controller: description,
                    onChanged: (_) {
                      canSave = true;
                    },
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            )),
      );
}
