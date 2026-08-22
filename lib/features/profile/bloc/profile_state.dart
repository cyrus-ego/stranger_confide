import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talk_first/data/models/response/profile_response.dart';
import 'package:talk_first/data/models/response/user_dto.dart';

part 'profile_state.freezed.dart';

enum ProfileStatus { initial, loading, loaded, updating, failure }

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.initial) ProfileStatus status,
    ProfileResponse? data,
    UserDto? currentUser,
    @Default(false) bool updateSuccess,
    @Default(false) bool createSuccess,
    @Default(false) bool loggedOut,
  }) = _ProfileState;
}
