import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/profile_response.dart';

part 'profile_state.freezed.dart';

enum ProfileStatus { initial, loading, loaded, failure }

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.initial) ProfileStatus status,
    ProfileResponse? data,
  }) = _ProfileState;
}
