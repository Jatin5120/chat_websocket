import 'package:chat_assignment/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@lazySingleton
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this._dbClient) : super(SplashInitial()) {
    on<StartSplash>(_onStartSplash);
  }

  final DbClient _dbClient;

  void _onStartSplash(StartSplash event, Emitter<SplashState> emit) {
    var isLoggedIn = _dbClient.getIsLoggedIn();
    if (isLoggedIn) {
      emit(SplashNavigateConversations());
    } else {
      emit(SplashNavigateAuth());
    }
  }
}
