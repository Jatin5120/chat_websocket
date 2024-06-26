import 'package:chat_assignment/blocs/blocs.dart';
import 'package:chat_assignment/models/models.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:chat_assignment/views/views.dart';
import 'package:chat_assignment/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              Utility.showInfoDialog(
                context,
                DialogModel.error(state.message),
              );
            }
            if (state is Authenticated) {
              context.read<ConversationsBloc>().add(LoadConversations());
              context.go(AppRoutes.conversations);
            }
          },
          builder: (context, state) {
            if (state is Authenticated) {
              return Text('Welcome ${state.user.name}');
            }
            return ResponsiveBuilder(
              mobile: SignupForm(
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
              ),
              desktop: Row(
                children: [
                  Flexible(
                    child: SignupForm(
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ),
                  const Flexible(
                    child: BlurredBackground(
                      radius: 0,
                      child: AuthSupport(
                        label: 'Join the Conversation',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
