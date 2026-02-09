import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _supabase = Supabase.instance.client;
  late final Stream<List<Map<String, dynamic>>> _notesStream;

  @override
  void initState() {
    super.initState();
    final userId = _supabase.auth.currentUser!.id;
    // Real-time stream: similar to an Observable in Angular
    _notesStream = _supabase
        .from('notes')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('inserted_at', ascending: false);
  }

  Future<void> _logout(BuildContext context) async {
    await _supabase.auth.signOut();
    if (mounted) context.go('/login');
  }

  void _showNoteDialog({Map<String, dynamic>? note}) {
    final titleController = TextEditingController(text: note?['title'] ?? '');
    final contentController =
        TextEditingController(text: note?['content'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note == null ? 'Create Note' : 'Edit Note'),
        // Setting a fixed width for the dialog on Web
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      labelText: 'Title', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                    labelText: 'Content', border: OutlineInputBorder()),
                maxLines: 5,
              ),
            ],
          ),
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
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reflections & Notes"),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _logout(context),
              tooltip: 'Logout'),
        ],
      ),
      // Center and SizedBox keep the UI from stretching too far on wide screens
      body: Center(
        child: SizedBox(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: _notesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(child: Text("Error: ${snapshot.error}"));
              if (!snapshot.hasData)
                return const Center(child: CircularProgressIndicator());

              final notes = snapshot.data!;
              if (notes.isEmpty)
                return const Center(
                    child: Text("No notes yet. Start writing."));

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      // hoverColor is a quick win for Web UX
                      hoverColor: Colors.blue.withOpacity(0.05),
                      title: Text(note['title'] ?? 'Untitled',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(note['content'] ?? '',
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.redAccent),
                        onPressed: () => _supabase
                            .from('notes')
                            .delete()
                            .eq('id', note['id']),
                      ),
                      onTap: () => _showNoteDialog(note: note),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNoteDialog(),
        label: const Text('New Note'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
