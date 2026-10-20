class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
  );

  static const String publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  static void validate() {
    if (url.isEmpty || publishableKey.isEmpty) {
      throw StateError(
        'Missing Supabase configuration. '
        'Provide SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY.',
      );
    }
  }
}