class Note {
  final int? id;
  final bool isImportant;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };

  static Note fromJson(Map<String, Object?> json) => Note(
      id: json[NoteFields.id] as int?,
      isImportant: (json[NoteFields.isImportant] == 1) ? true : false,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      createdTime: DateTime.parse(json[NoteFields.time] as String));

  Note copy({
    int? id,
    bool? isImportant,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
          id: id ?? this.id,
          isImportant: isImportant ?? this.isImportant,
          title: title ?? this.title,
          description: description ?? this.description,
          createdTime: createdTime ?? this.createdTime);
}

const String tableNotes = "notes";

class NoteFields {
  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';

  static const List<String> values = [
    id,
    isImportant,
    title,
    description,
    time,
  ];
}
