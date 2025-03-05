# time_left

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Environment Variables

This project uses environment variables to manage sensitive information like API keys. Follow these steps to set up:

1. Create a `.env` file in the root directory of the project (or copy and rename the `.env.example` file)
2. Add the following environment variables to your `.env` file:

```
SUPABASE_URL=your_supabase_url_here
SUPABASE_ANON_KEY=your_supabase_anon_key_here
SUPABASE_SERVICE_ROLE=your_supabase_service_role_here
```

3. Replace the placeholder values with your actual Supabase credentials
4. Make sure not to commit your `.env` file to version control (it should be listed in `.gitignore`)
