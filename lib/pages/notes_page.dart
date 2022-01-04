import 'package:flutter/material.dart';
import 'package:sql_database_example/db/notes_db.dart';
import 'package:sql_database_example/model/note.dart';
import 'package:sql_database_example/pages/new_note_page.dart';
import 'package:sql_database_example/pages/note_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;
  Color tileColor = const Color(0xff457b9d);
  int navigatorIndex = 0;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await NotesDatabases.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes by yassine Alsmayli"),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddNote(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: isLoading ? const CircularProgressIndicator() : notesList(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              navigatorIndex = value;
            });
          },
          currentIndex: navigatorIndex,
          showSelectedLabels: true,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.notes), label: "Notes"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          ]),
    );
  }

  Widget notesList() => Wrap(
        spacing: 20,
        children: notes.map((e) => notesTile(e.title, e.id)).toList(),
      );

  Widget notesTile(String title, int? id) => InkWell(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: tileColor,
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [tileColor.withOpacity(0.5), tileColor])),
          child: Center(
            child: Text(title),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NotePage(id),
          ));
        },
      );
}
