import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stranger_confide/data/models/request/update_profile_request.dart';

part 'profile_event.freezed.dart';

@freezed
sealed class ProfileEvent extends BlocEvent with _$ProfileEvent {
  const ProfileEvent._();

  const factory ProfileEvent.load() = ProfileLoad;
  const factory ProfileEvent.update(UpdateProfileRequest request) =
      ProfileUpdate;
  const factory ProfileEvent.patchField(Map<String, dynamic> fields) =
      ProfilePatchField;
  const factory ProfileEvent.logout() = ProfileLogout;
}
