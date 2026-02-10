import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_geoff_notes_app/pages/create_note_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 1. Create a stream to listen to notes for the current user
  late Stream<List<Map<String, dynamic>>> _notesStream;

  @override
  void initState() {
    super.initState();
    _initStream();
  }

  // Helper to initialize or reset the stream logic
  void _initStream() {
    _notesStream = Supabase.instance.client
        .from('notes')
        .stream(primaryKey: ['id'])
        .order('id', ascending: false);
  }

  // Helper to truncate content
  String _truncateContent(String content) {
    if (content.length <= 20) return content;
    return '${content.substring(0, 20)}...';
  }

  Future<void> _handleLogout() async {
    await Supabase.instance.client.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Apple Journal uses a very light gray or off-white background
      backgroundColor: const Color(0xFFF2F2F7),
      drawer: _buildDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFAB(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        edgeOffset: 100, // Starts the spinner below the Large Title
        color: Colors.deepPurple,
        child: CustomScrollView(
          // Important for RefreshIndicator: The scroll view must always be scrollable
          // even if there are no items, otherwise you can't "pull".
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar.large(
              backgroundColor: const Color(0xFFF2F2F7),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                  color: Colors.black,
                ),
              ),
            ),

            // Your existing StreamBuilder goes here...
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _notesStream,
              builder: (context, snapshot) {
                // ... (Keep your existing error/loading/empty logic)

                final notes = snapshot.data ?? [];
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildJournalCard(notes[index]),
                    childCount: notes.length,
                  ),
                );
              },
            ),

            // Bottom spacing
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalCard(Map<String, dynamic> note) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24), // High radius like iOS
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note['title'] ?? 'Untitled',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _truncateContent(note['content'] ?? ''),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'The Inner Citadel',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              _handleLogout();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.large(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CreateNotePage(),
            fullscreenDialog: true,
          ),
        );
      },
      backgroundColor: Colors.white,
      // Using a subtle shadow and deepPurple icon to match your theme
      child: const Icon(Icons.add, size: 36, color: Colors.deepPurple),
    );
  }

  Future<void> _onRefresh() async {
    // With Supabase .stream(), it technically updates in real-time.
    // However, adding a manual refresh is great for user feedback or
    // re-triggering the stream if the connection was lost.
    setState(() {
      // Re-assigning the stream triggers a fresh fetch
      // _notesStream = Supabase.instance.client
      //     .from('notes')
      //     .stream(primaryKey: ['id'])
      //     .order('id', ascending: false);
      _initStream();
    });

    // Artificial delay to make the "spinner" feel natural to the user
    await Future.delayed(const Duration(milliseconds: 800));
  }
}
