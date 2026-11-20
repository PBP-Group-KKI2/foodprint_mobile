// Override with --dart-define, e.g. API_BASE_URL=http://10.0.2.2:8000 for the Android emulator.
const String baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8000',
);
