import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_geoff_notes_app/config/supabase_config.dart';
import 'package:flutter_geoff_notes_app/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Provide an in-memory implementation for SharedPreferences.
    SharedPreferences.setMockInitialValues({});

    // Initialize Supabase using your existing configuration.
    SupabaseConfig.validate();

    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.publishableKey,
    );
  });

  testWidgets('App displays the login screen', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Allow the authentication stream to emit its initial state.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('The Inner Citadel'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Begin Reflection'), findsOneWidget);
  });
}