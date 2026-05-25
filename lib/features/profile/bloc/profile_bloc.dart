import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@injectable
class ProfileBloc extends AppBloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._getProfileUseCase) : super(const ProfileState()) {
    on<ProfileLoad>(_onLoad);
  }

  final GetProfileUseCase _getProfileUseCase;

  Future<void> _onLoad(
    ProfileLoad event,
    Emitter<ProfileState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: ProfileStatus.loading));

        final data = (await _getProfileUseCase())
            .orThrow((_) => emit(state.copyWith(status: ProfileStatus.failure)));

        emit(state.copyWith(status: ProfileStatus.loaded, data: data));
      });
}
