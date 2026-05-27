import '../../core/locale/locale_keys.dart';

enum Gender {
  male('male'),
  female('female');

  const Gender(this.value);

  final String value;

  Gender get opposite => switch (this) {
        Gender.male => Gender.female,
        Gender.female => Gender.male,
      };

  String get labelKey => switch (this) {
        Gender.male => LocaleKeys.profileMale,
        Gender.female => LocaleKeys.profileFemale,
      };

  static Gender? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    for (final g in values) {
      if (g.value == raw) return g;
    }
    return null;
  }
}

/// Lọc giới tính đối phương khi matchmaking (`''` = bất kỳ).
enum PreferredGenderFilter {
  any(''),
  male('male'),
  female('female');

  const PreferredGenderFilter(this.value);

  final String value;

  String get labelKey => switch (this) {
        PreferredGenderFilter.any => LocaleKeys.profileAny,
        PreferredGenderFilter.male => LocaleKeys.profileMale,
        PreferredGenderFilter.female => LocaleKeys.profileFemale,
      };

  static PreferredGenderFilter tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return PreferredGenderFilter.any;
    for (final f in values) {
      if (f.value == raw) return f;
    }
    return PreferredGenderFilter.any;
  }
}
