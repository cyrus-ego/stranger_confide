import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_first/data/datasources/profile_remote_datasource.dart';
import 'package:talk_first/data/models/request/update_profile_request.dart';
import 'package:talk_first/data/models/response/profile_response.dart';

import '../../domain/repositories/profile_repository.dart';
import 'base_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends BaseRepository
    implements ProfileRepository {
  ProfileRepositoryImpl(this._remoteDatasource);

  final ProfileRemoteDatasource _remoteDatasource;

  @override
  Future<AppResult<ProfileResponse>> getProfile() =>
      safeApiCall(() => _remoteDatasource.getProfile());

  @override
  Future<AppResult<ProfileResponse>> createProfile(
    UpdateProfileRequest request,
  ) => safeApiCall(() => _remoteDatasource.createProfile(request));

  @override
  Future<AppResult<ProfileResponse>> updateProfile(
    UpdateProfileRequest request,
  ) => safeApiCall(() => _remoteDatasource.updateProfile(request));

  @override
  Future<AppResult<ProfileResponse>> patchProfile(
    Map<String, dynamic> fields,
  ) => safeApiCall(() => _remoteDatasource.patchProfile(fields));
}
