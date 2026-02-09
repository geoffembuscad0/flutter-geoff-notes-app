import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

// Assuming you named the service file we discussed earlier
// import 'package:your_app_name/services/note_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _supabase = Supabase.instance.client;

  // In a larger app, you'd inject this, but for now, we'll instantiate it
  // Using the stream logic we discussed for real-time updates
  late final Stream<List<Map<String, dynamic>>> _notesStream;

  @override
  void initState() {
    super.initState();
    final userId = _supabase.auth.currentUser!.id;
    _notesStream = _supabase
        .from('notes')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('inserted_at');
  }

  Future<void> _logout(BuildContext context) async {
    await _supabase.auth.signOut();
    if (mounted) context.go('/login');
  }

  // Logic to handle Create and Edit
  void _showNoteDialog({Map<String, dynamic>? note}) {
    final titleController = TextEditingController(text: note?['title'] ?? '');
    final contentController =
        TextEditingController(text: note?['content'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note == null ? 'New Note' : 'Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 3),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text;
              final content = contentController.text;
              if (note == null) {
                await _supabase.from('notes').insert({
                  'user_id': _supabase.auth.currentUser!.id,
                  'title': title,
                  'content': content
                });
              } else {
                await _supabase.from('notes').update(
                    {'title': title, 'content': content}).eq('id', note['id']);
              }
              if (mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout), onPressed: () => _logout(context))
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final notes = snapshot.data!;
          if (notes.isEmpty)
            return const Center(child: Text("No notes yet. Tap + to start."));

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(note['title'] ?? 'No Title'),
                  subtitle: Text(note['content'] ?? ''),
                  onTap: () => _showNoteDialog(note: note),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () async {
                      await _supabase
                          .from('notes')
                          .delete()
                          .eq('id', note['id']);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
