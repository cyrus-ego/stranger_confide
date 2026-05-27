import '../../core/locale/locale_keys.dart';

enum ChatPreference {
  opposite('opposite'),
  same('same'),
  any('any');

  const ChatPreference(this.value);

  final String value;

  static const ChatPreference defaultPreference = ChatPreference.any;

  String get labelKey => switch (this) {
        ChatPreference.opposite => LocaleKeys.profileOpposite,
        ChatPreference.same => LocaleKeys.profileSame,
        ChatPreference.any => LocaleKeys.profileAny,
      };

  static ChatPreference tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return ChatPreference.any;
    for (final p in values) {
      if (p.value == raw) return p;
    }
    return ChatPreference.any;
  }
}
