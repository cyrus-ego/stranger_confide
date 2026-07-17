import '../../core/locale/locale_keys.dart';

enum Gender {
  male('male'),
  female('female'),
  other('other');

  const Gender(this.value);

  final String value;

  Gender get opposite => switch (this) {
        Gender.male => Gender.female,
        Gender.female => Gender.male,
        Gender.other => Gender.other,
      };

  String get labelKey => switch (this) {
        Gender.male => LocaleKeys.profileMale,
        Gender.female => LocaleKeys.profileFemale,
        Gender.other => LocaleKeys.profileOther,
      };

  static Gender? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    for (final g in values) {
      if (g.value == raw) return g;
    }
    return null;
  }
}
