import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/token_storage.dart';
import '../../../domain/services/google_sign_in_service.dart';
import '../../../domain/usecases/create_profile_usecase.dart';
import '../../../domain/usecases/get_current_user_usecase.dart';
import '../../../domain/usecases/get_profile_usecase.dart';
import '../../../domain/usecases/patch_profile_usecase.dart';
import '../../../domain/usecases/update_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@injectable
class ProfileBloc extends AppBloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._getProfileUseCase,
    this._getCurrentUserUseCase,
    this._createProfileUseCase,
    this._updateProfileUseCase,
    this._patchProfileUseCase,
    this._tokenStorage,
    this._googleSignInService,
  ) : super(const ProfileState()) {
    on<ProfileLoad>(_onLoad);
    on<ProfileLoadMe>(_onLoadMe);
    on<ProfileCreate>(_onCreate);
    on<ProfileUpdate>(_onUpdate);
    on<ProfilePatchField>(_onPatchField);
    on<ProfileLogout>(_onLogout);
  }

  final GetProfileUseCase _getProfileUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final CreateProfileUseCase _createProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final PatchProfileUseCase _patchProfileUseCase;
  final TokenStorage _tokenStorage;
  final GoogleSignInService _googleSignInService;

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

  Future<void> _onLoadMe(
    ProfileLoadMe event,
    Emitter<ProfileState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: ProfileStatus.loading));

        final user = (await _getCurrentUserUseCase())
            .orThrow((_) => emit(state.copyWith(status: ProfileStatus.failure)));

        emit(state.copyWith(
          status: ProfileStatus.loaded,
          currentUser: user,
        ));
      });

  Future<void> _onCreate(
    ProfileCreate event,
    Emitter<ProfileState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: ProfileStatus.updating, createSuccess: false));

        final data = (await _createProfileUseCase(event.request))
            .orThrow((_) => emit(state.copyWith(status: ProfileStatus.failure)));

        emit(state.copyWith(
          status: ProfileStatus.loaded,
          data: data,
          createSuccess: true,
        ));
      });

  Future<void> _onUpdate(
    ProfileUpdate event,
    Emitter<ProfileState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: ProfileStatus.updating, updateSuccess: false));

        final data = (await _updateProfileUseCase(event.request))
            .orThrow((_) => emit(state.copyWith(status: ProfileStatus.loaded)));

        emit(state.copyWith(
          status: ProfileStatus.loaded,
          data: data,
          updateSuccess: true,
        ));
      });

  Future<void> _onPatchField(
    ProfilePatchField event,
    Emitter<ProfileState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: ProfileStatus.updating, updateSuccess: false));

        final data = (await _patchProfileUseCase(event.fields))
            .orThrow((_) => emit(state.copyWith(status: ProfileStatus.loaded)));

        emit(state.copyWith(
          status: ProfileStatus.loaded,
          data: data,
          updateSuccess: true,
        ));
      });

  Future<void> _onLogout(ProfileLogout event, Emitter<ProfileState> emit) async {
    await _tokenStorage.clear();
    try {
      await _googleSignInService.signOut();
    } catch (_) {
      // The app session is already cleared; a provider sign-out failure must
      // not prevent the user from logging out locally.
    }
    emit(state.copyWith(loggedOut: true));
  }
}
