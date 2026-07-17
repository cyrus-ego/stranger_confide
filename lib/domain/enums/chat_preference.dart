import '../../core/locale/locale_keys.dart';

enum ChatPreference {
  male('male'),
  female('female'),
  other('other');

  const ChatPreference(this.value);

  final String value;

  static const ChatPreference defaultPreference = ChatPreference.female;

  String get labelKey => switch (this) {
        ChatPreference.male => LocaleKeys.profileMale,
        ChatPreference.female => LocaleKeys.profileFemale,
        ChatPreference.other => LocaleKeys.profileOther,
      };

  static ChatPreference tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return defaultPreference;
    for (final p in values) {
      if (p.value == raw) return p;
    }
    return defaultPreference;
  }
}
