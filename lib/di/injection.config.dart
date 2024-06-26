// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chat_assignment/blocs/auth/auth_bloc.dart' as _i12;
import 'package:chat_assignment/blocs/chat/chat_bloc.dart' as _i13;
import 'package:chat_assignment/blocs/conversations/conversations_bloc.dart'
    as _i9;
import 'package:chat_assignment/blocs/splash/splash_bloc.dart' as _i4;
import 'package:chat_assignment/data/data.dart' as _i5;
import 'package:chat_assignment/data/local/db_client.dart' as _i3;
import 'package:chat_assignment/services/auth_service.dart' as _i11;
import 'package:chat_assignment/services/conversation_service.dart' as _i7;
import 'package:chat_assignment/services/message_service.dart' as _i6;
import 'package:chat_assignment/services/services.dart' as _i10;
import 'package:chat_assignment/services/user_service.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.DbClient>(() => _i3.DbClient());
    gh.lazySingleton<_i4.SplashBloc>(() => _i4.SplashBloc(gh<_i5.DbClient>()));
    gh.lazySingleton<_i6.MessageService>(
        () => _i6.MessageService(gh<_i5.DbClient>()));
    gh.lazySingleton<_i7.ConversationService>(
        () => _i7.ConversationService(gh<_i5.DbClient>()));
    gh.lazySingleton<_i8.UserService>(
        () => _i8.UserService(gh<_i5.DbClient>()));
    gh.lazySingleton<_i9.ConversationsBloc>(() => _i9.ConversationsBloc(
        conversationService: gh<_i10.ConversationService>()));
    gh.lazySingleton<_i11.AuthService>(() => _i11.AuthService(
          gh<_i5.DbClient>(),
          gh<_i10.UserService>(),
        ));
    gh.lazySingleton<_i12.AuthBloc>(
        () => _i12.AuthBloc(gh<_i10.AuthService>()));
    gh.lazySingleton<_i13.ChatBloc>(
        () => _i13.ChatBloc(messageService: gh<_i6.MessageService>()));
    return this;
  }
}
