// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:stranger_confide/core/di/register_module.dart' as _i661;
import 'package:stranger_confide/core/token_storage.dart' as _i670;
import 'package:stranger_confide/data/datasources/auth_remote_datasource.dart'
    as _i999;
import 'package:stranger_confide/data/datasources/profile_remote_datasource.dart'
    as _i962;
import 'package:stranger_confide/data/repositories/auth_repository_impl.dart'
    as _i1019;
import 'package:stranger_confide/data/repositories/profile_repository_impl.dart'
    as _i412;
import 'package:stranger_confide/domain/repositories/auth_repository.dart'
    as _i982;
import 'package:stranger_confide/domain/repositories/profile_repository.dart'
    as _i34;
import 'package:stranger_confide/domain/usecases/get_profile_usecase.dart'
    as _i669;
import 'package:stranger_confide/domain/usecases/login_usecase.dart' as _i878;
import 'package:stranger_confide/features/auth/bloc/login_bloc.dart' as _i209;
import 'package:stranger_confide/features/profile/bloc/profile_bloc.dart'
    as _i162;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i999.AuthRemoteDatasource>(
      () => registerModule.authRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i962.ProfileRemoteDatasource>(
      () => registerModule.profileRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i34.ProfileRepository>(
      () => _i412.ProfileRepositoryImpl(gh<_i962.ProfileRemoteDatasource>()),
    );
    gh.lazySingleton<_i982.AuthRepository>(
      () => _i1019.AuthRepositoryImpl(gh<_i999.AuthRemoteDatasource>()),
    );
    gh.factory<_i669.GetProfileUseCase>(
      () => _i669.GetProfileUseCase(gh<_i34.ProfileRepository>()),
    );
    gh.factory<_i878.LoginUseCase>(
      () => _i878.LoginUseCase(gh<_i982.AuthRepository>()),
    );
    gh.factory<_i209.LoginBloc>(
      () => _i209.LoginBloc(gh<_i878.LoginUseCase>(), gh<_i670.TokenStorage>()),
    );
    gh.factory<_i162.ProfileBloc>(
      () => _i162.ProfileBloc(gh<_i669.GetProfileUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i661.RegisterModule {}
