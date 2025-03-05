import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  // Get values from .env file with fallbacks to empty strings
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get supabaseServiceRole =>
      dotenv.env['SUPABASE_SERVICE_ROLE'] ?? '';
}
