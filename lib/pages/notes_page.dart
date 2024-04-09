import 'package:flutter/material.dart';
import 'package:flutter_geoff_notes_app/components/drawer.dart';
import 'package:flutter_geoff_notes_app/components/note_tile.dart';
import 'package:flutter_geoff_notes_app/models/note.dart';
import 'package:flutter_geoff_notes_app/models/note_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    readNotes();
  }

  final textController = TextEditingController();

  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
              content: TextField(
                controller: textController,
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                maxLines: null,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<NoteDatabase>().addNote(textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Create"),
                )
              ],
            ));
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    textController.text = note.text;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
              content: TextField(
                controller: textController,
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                maxLines: null,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                )
              ],
            ));
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: createNote,
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary,),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: currentNotes.length,
                  itemBuilder: (context, index) {
                    final note = currentNotes[index];
                    return NoteTile(
                      text: note.text,
                      onEditPressed: () => updateNote(note),
                      onDeletePressed: () => deleteNote(note.id),
                    );
                  }))
        ],
      ),
    );
  }
}
