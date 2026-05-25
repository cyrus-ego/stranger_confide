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
import 'package:stranger_confide/features/auth/data/auth_api.dart' as _i596;
import 'package:stranger_confide/features/auth/data/auth_repository.dart'
    as _i892;
import 'package:stranger_confide/features/auth/presentation/bloc/login_bloc.dart'
    as _i988;
import 'package:stranger_confide/features/profile/data/profile_api.dart'
    as _i847;
import 'package:stranger_confide/features/profile/data/profile_repository.dart'
    as _i994;
import 'package:stranger_confide/features/profile/presentation/bloc/profile_bloc.dart'
    as _i1006;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i596.AuthApi>(
      () => registerModule.authApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i847.ProfileApi>(
      () => registerModule.profileApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i994.ProfileRepository>(
      () => _i994.ProfileRepository(gh<_i847.ProfileApi>()),
    );
    gh.lazySingleton<_i892.AuthRepository>(
      () => _i892.AuthRepository(gh<_i596.AuthApi>()),
    );
    gh.factory<_i1006.ProfileBloc>(
      () => _i1006.ProfileBloc(gh<_i994.ProfileRepository>()),
    );
    gh.factory<_i988.LoginBloc>(
      () =>
          _i988.LoginBloc(gh<_i892.AuthRepository>(), gh<_i670.TokenStorage>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i661.RegisterModule {}
