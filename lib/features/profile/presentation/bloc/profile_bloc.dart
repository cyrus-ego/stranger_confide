import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@injectable
class ProfileBloc extends AppBloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._repo) : super(const ProfileState()) {
    on<ProfileLoad>(_onLoad);
  }

  final ProfileRepository _repo;

  Future<void> _onLoad(
    ProfileLoad event,
    Emitter<ProfileState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: ProfileStatus.loading));

        final data = (await _repo.getProfile())
            .orThrow((_) => emit(state.copyWith(status: ProfileStatus.failure)));

        emit(state.copyWith(status: ProfileStatus.loaded, data: data));
      });
}
