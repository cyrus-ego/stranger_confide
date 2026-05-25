import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stranger_confide/data/models/response/profile_response.dart';


part 'profile_state.freezed.dart';

enum ProfileStatus { initial, loading, loaded, failure }

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.initial) ProfileStatus status,
    ProfileResponse? data,
  }) = _ProfileState;
}
