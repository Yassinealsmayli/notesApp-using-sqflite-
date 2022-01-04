import 'package:flutter/material.dart';
import 'package:sql_database_example/pages/notes_page.dart';

main() => runApp(const MyApp());



class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotesPage(),
    );
  }
}
