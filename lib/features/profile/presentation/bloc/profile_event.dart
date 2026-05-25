import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
sealed class ProfileEvent extends BlocEvent with _$ProfileEvent {
  const ProfileEvent._();

  const factory ProfileEvent.load() = ProfileLoad;
}
