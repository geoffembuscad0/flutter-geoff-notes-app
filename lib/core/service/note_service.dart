import 'package:supabase_flutter/supabase_flutter.dart';

class NoteService {
  final _supabase = Supabase.instance.client;

  // READ: Get all notes for the logged-in user
  Stream<List<Map<String, dynamic>>> get notesStream {
    final userId = _supabase.auth.currentUser!.id;
    return _supabase
        .from('notes')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('inserted_at', ascending: false);
  }

  // CREATE
  Future<void> addNote(String title, String content) async {
    await _supabase.from('notes').insert({
      'user_id': _supabase.auth.currentUser!.id,
      'title': title,
      'content': content,
    });
  }

  // UPDATE
  Future<void> updateNote(String id, String title, String content) async {
    await _supabase.from('notes').update({
      'title': title,
      'content': content,
    }).eq('id', id);
  }

  // DELETE
  Future<void> deleteNote(String id) async {
    await _supabase.from('notes').delete().eq('id', id);
  }
}
