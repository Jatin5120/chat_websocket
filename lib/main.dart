import 'package:chat_assignment/blocs/blocs.dart';
import 'package:chat_assignment/data/data.dart';
import 'package:chat_assignment/di/di.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:chat_assignment/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  await Future.wait([
    getIt<DbClient>().initialize(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<AuthBloc>()),
          BlocProvider(create: (_) => getIt<SplashBloc>()),
          BlocProvider(create: (_) => getIt<ConversationsBloc>()),
          BlocProvider(create: (_) => getIt<ChatBloc>()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: kTheme(context),
          builder: (context, child) => DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ResponsiveBuilder(
              mobile: child ?? const SizedBox(),
              desktop: Padding(
                padding: const EdgeInsets.all(40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: child,
                ),
              ),
            ),
          ),
          routerConfig: AppRouter.router(context),
        ),
      );
}
