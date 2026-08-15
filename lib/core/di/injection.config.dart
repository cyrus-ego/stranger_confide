// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cyr_app_kit/cyr_app_kit.dart' as _i512;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:stranger_confide/core/di/register_module.dart' as _i661;
import 'package:stranger_confide/data/datasources/auth_remote_datasource.dart'
    as _i999;
import 'package:stranger_confide/data/datasources/chat_remote_datasource.dart'
    as _i1068;
import 'package:stranger_confide/data/datasources/facebook_sign_in_service.dart'
    as _i720;
import 'package:stranger_confide/data/datasources/google_sign_in_service.dart'
    as _i370;
import 'package:stranger_confide/data/datasources/matchmaking_remote_datasource.dart'
    as _i854;
import 'package:stranger_confide/data/datasources/matchmaking_socket_service.dart'
    as _i910;
import 'package:stranger_confide/data/datasources/moderation_remote_datasource.dart'
    as _i708;
import 'package:stranger_confide/data/datasources/profile_remote_datasource.dart'
    as _i962;
import 'package:stranger_confide/data/datasources/room_remote_datasource.dart'
    as _i916;
import 'package:stranger_confide/data/datasources/user_remote_datasource.dart'
    as _i510;
import 'package:stranger_confide/data/repositories/auth_repository_impl.dart'
    as _i1019;
import 'package:stranger_confide/data/repositories/chat_repository_impl.dart'
    as _i236;
import 'package:stranger_confide/data/repositories/matchmaking_repository_impl.dart'
    as _i433;
import 'package:stranger_confide/data/repositories/moderation_repository_impl.dart'
    as _i807;
import 'package:stranger_confide/data/repositories/profile_repository_impl.dart'
    as _i412;
import 'package:stranger_confide/data/repositories/room_repository_impl.dart'
    as _i836;
import 'package:stranger_confide/data/repositories/user_repository_impl.dart'
    as _i263;
import 'package:stranger_confide/domain/repositories/auth_repository.dart'
    as _i982;
import 'package:stranger_confide/domain/repositories/chat_repository.dart'
    as _i926;
import 'package:stranger_confide/domain/repositories/matchmaking_repository.dart'
    as _i304;
import 'package:stranger_confide/domain/repositories/moderation_repository.dart'
    as _i396;
import 'package:stranger_confide/domain/repositories/profile_repository.dart'
    as _i34;
import 'package:stranger_confide/domain/repositories/room_repository.dart'
    as _i133;
import 'package:stranger_confide/domain/repositories/user_repository.dart'
    as _i687;
import 'package:stranger_confide/domain/services/facebook_sign_in_service.dart'
    as _i925;
import 'package:stranger_confide/domain/services/google_sign_in_service.dart'
    as _i942;
import 'package:stranger_confide/domain/usecases/create_profile_usecase.dart'
    as _i115;
import 'package:stranger_confide/domain/usecases/facebook_login_usecase.dart'
    as _i875;
import 'package:stranger_confide/domain/usecases/get_active_room_usecase.dart'
    as _i990;
import 'package:stranger_confide/domain/usecases/get_chat_messages_usecase.dart'
    as _i720;
import 'package:stranger_confide/domain/usecases/get_current_user_usecase.dart'
    as _i1047;
import 'package:stranger_confide/domain/usecases/get_profile_usecase.dart'
    as _i669;
import 'package:stranger_confide/domain/usecases/get_queue_status_usecase.dart'
    as _i438;
import 'package:stranger_confide/domain/usecases/google_login_usecase.dart'
    as _i762;
import 'package:stranger_confide/domain/usecases/join_queue_usecase.dart'
    as _i443;
import 'package:stranger_confide/domain/usecases/leave_queue_usecase.dart'
    as _i569;
import 'package:stranger_confide/domain/usecases/leave_room_usecase.dart'
    as _i212;
import 'package:stranger_confide/domain/usecases/login_usecase.dart' as _i878;
import 'package:stranger_confide/domain/usecases/patch_profile_usecase.dart'
    as _i247;
import 'package:stranger_confide/domain/usecases/register_usecase.dart'
    as _i419;
import 'package:stranger_confide/domain/usecases/report_user_usecase.dart'
    as _i691;
import 'package:stranger_confide/domain/usecases/resend_otp_usecase.dart'
    as _i225;
import 'package:stranger_confide/domain/usecases/update_profile_usecase.dart'
    as _i853;
import 'package:stranger_confide/domain/usecases/upload_chat_image_usecase.dart'
    as _i167;
import 'package:stranger_confide/domain/usecases/verify_email_usecase.dart'
    as _i29;
import 'package:stranger_confide/features/auth/bloc/login_bloc.dart' as _i209;
import 'package:stranger_confide/features/chat/bloc/chat_bloc.dart' as _i460;
import 'package:stranger_confide/features/matchmaking/bloc/matchmaking_bloc.dart'
    as _i987;
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
    gh.lazySingleton<_i942.GoogleSignInService>(
      () => _i370.GoogleSignInServiceImpl(),
    );
    gh.lazySingleton<_i925.FacebookSignInService>(
      () => _i720.FacebookSignInServiceImpl(),
    );
    gh.lazySingleton<_i999.AuthRemoteDatasource>(
      () => registerModule.authRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1068.ChatRemoteDatasource>(
      () => registerModule.chatRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i510.UserRemoteDatasource>(
      () => registerModule.userRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i962.ProfileRemoteDatasource>(
      () => registerModule.profileRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i854.MatchmakingRemoteDatasource>(
      () => registerModule.matchmakingRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i916.RoomRemoteDatasource>(
      () => registerModule.roomRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i708.ModerationRemoteDatasource>(
      () => registerModule.moderationRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i133.RoomRepository>(
      () => _i836.RoomRepositoryImpl(gh<_i916.RoomRemoteDatasource>()),
    );
    gh.lazySingleton<_i304.MatchmakingRepository>(
      () => _i433.MatchmakingRepositoryImpl(
        gh<_i854.MatchmakingRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i34.ProfileRepository>(
      () => _i412.ProfileRepositoryImpl(gh<_i962.ProfileRemoteDatasource>()),
    );
    gh.lazySingleton<_i926.ChatRepository>(
      () => _i236.ChatRepositoryImpl(gh<_i1068.ChatRemoteDatasource>()),
    );
    gh.lazySingleton<_i982.AuthRepository>(
      () => _i1019.AuthRepositoryImpl(gh<_i999.AuthRemoteDatasource>()),
    );
    gh.lazySingleton<_i687.UserRepository>(
      () => _i263.UserRepositoryImpl(gh<_i510.UserRemoteDatasource>()),
    );
    gh.lazySingleton<_i910.MatchmakingSocketService>(
      () => _i910.MatchmakingSocketService(gh<_i512.TokenStorage>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i512.PushNotificationService>(
      () => registerModule.pushNotificationService(
        gh<_i512.TokenStorage>(),
        gh<_i510.UserRemoteDatasource>(),
      ),
    );
    gh.factory<_i990.GetActiveRoomUseCase>(
      () => _i990.GetActiveRoomUseCase(gh<_i133.RoomRepository>()),
    );
    gh.factory<_i212.LeaveRoomUseCase>(
      () => _i212.LeaveRoomUseCase(gh<_i133.RoomRepository>()),
    );
    gh.factory<_i438.GetQueueStatusUseCase>(
      () => _i438.GetQueueStatusUseCase(gh<_i304.MatchmakingRepository>()),
    );
    gh.factory<_i443.JoinQueueUseCase>(
      () => _i443.JoinQueueUseCase(gh<_i304.MatchmakingRepository>()),
    );
    gh.factory<_i569.LeaveQueueUseCase>(
      () => _i569.LeaveQueueUseCase(gh<_i304.MatchmakingRepository>()),
    );
    gh.factory<_i115.CreateProfileUseCase>(
      () => _i115.CreateProfileUseCase(gh<_i34.ProfileRepository>()),
    );
    gh.factory<_i669.GetProfileUseCase>(
      () => _i669.GetProfileUseCase(gh<_i34.ProfileRepository>()),
    );
    gh.factory<_i247.PatchProfileUseCase>(
      () => _i247.PatchProfileUseCase(gh<_i34.ProfileRepository>()),
    );
    gh.factory<_i853.UpdateProfileUseCase>(
      () => _i853.UpdateProfileUseCase(gh<_i34.ProfileRepository>()),
    );
    gh.lazySingleton<_i396.ModerationRepository>(
      () => _i807.ModerationRepositoryImpl(
        gh<_i708.ModerationRemoteDatasource>(),
      ),
    );
    gh.factory<_i875.FacebookLoginUseCase>(
      () => _i875.FacebookLoginUseCase(gh<_i982.AuthRepository>()),
    );
    gh.factory<_i762.GoogleLoginUseCase>(
      () => _i762.GoogleLoginUseCase(gh<_i982.AuthRepository>()),
    );
    gh.factory<_i878.LoginUseCase>(
      () => _i878.LoginUseCase(gh<_i982.AuthRepository>()),
    );
    gh.factory<_i419.RegisterUseCase>(
      () => _i419.RegisterUseCase(gh<_i982.AuthRepository>()),
    );
    gh.factory<_i225.ResendOtpUseCase>(
      () => _i225.ResendOtpUseCase(gh<_i982.AuthRepository>()),
    );
    gh.factory<_i29.VerifyEmailUseCase>(
      () => _i29.VerifyEmailUseCase(gh<_i982.AuthRepository>()),
    );
    gh.factory<_i691.ReportUserUseCase>(
      () => _i691.ReportUserUseCase(gh<_i396.ModerationRepository>()),
    );
    gh.factory<_i720.GetChatMessagesUseCase>(
      () => _i720.GetChatMessagesUseCase(gh<_i926.ChatRepository>()),
    );
    gh.factory<_i167.UploadChatImageUseCase>(
      () => _i167.UploadChatImageUseCase(gh<_i926.ChatRepository>()),
    );
    gh.factory<_i1047.GetCurrentUserUseCase>(
      () => _i1047.GetCurrentUserUseCase(gh<_i687.UserRepository>()),
    );
    gh.factory<_i209.LoginBloc>(
      () => _i209.LoginBloc(
        gh<_i878.LoginUseCase>(),
        gh<_i762.GoogleLoginUseCase>(),
        gh<_i942.GoogleSignInService>(),
        gh<_i875.FacebookLoginUseCase>(),
        gh<_i925.FacebookSignInService>(),
        gh<_i419.RegisterUseCase>(),
        gh<_i225.ResendOtpUseCase>(),
        gh<_i29.VerifyEmailUseCase>(),
        gh<_i512.TokenStorage>(),
        gh<_i512.PushNotificationService>(),
      ),
    );
    gh.factory<_i987.MatchmakingBloc>(
      () => _i987.MatchmakingBloc(
        gh<_i443.JoinQueueUseCase>(),
        gh<_i569.LeaveQueueUseCase>(),
        gh<_i669.GetProfileUseCase>(),
        gh<_i990.GetActiveRoomUseCase>(),
        gh<_i438.GetQueueStatusUseCase>(),
        gh<_i247.PatchProfileUseCase>(),
        gh<_i910.MatchmakingSocketService>(),
      ),
    );
    gh.factory<_i162.ProfileBloc>(
      () => _i162.ProfileBloc(
        gh<_i669.GetProfileUseCase>(),
        gh<_i1047.GetCurrentUserUseCase>(),
        gh<_i115.CreateProfileUseCase>(),
        gh<_i853.UpdateProfileUseCase>(),
        gh<_i247.PatchProfileUseCase>(),
        gh<_i512.TokenStorage>(),
        gh<_i942.GoogleSignInService>(),
        gh<_i925.FacebookSignInService>(),
        gh<_i512.PushNotificationService>(),
      ),
    );
    gh.factory<_i460.ChatBloc>(
      () => _i460.ChatBloc(
        gh<_i512.TokenStorage>(),
        gh<_i990.GetActiveRoomUseCase>(),
        gh<_i212.LeaveRoomUseCase>(),
        gh<_i691.ReportUserUseCase>(),
        gh<_i720.GetChatMessagesUseCase>(),
        gh<_i167.UploadChatImageUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i661.RegisterModule {}
