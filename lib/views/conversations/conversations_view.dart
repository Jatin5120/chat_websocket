import 'package:chat_assignment/blocs/blocs.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:chat_assignment/views/views.dart';
import 'package:chat_assignment/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ConversationsView extends StatelessWidget {
  const ConversationsView({
    super.key,
    this.conversationId,
  });

  final String? conversationId;

  @override
  Widget build(BuildContext context) {
    if (conversationId != null && conversationId!.trim().isNotEmpty) {
      context.read<ConversationsBloc>().add(
            SelectConversation(conversationId!),
          );
    } else {
      context.read<ConversationsBloc>().add(UnselectConversation());
    }
    return BlocBuilder<ConversationsBloc, ConversationsState>(
      builder: (context, state) {
        if (state is ConversationsLoaded) {
          return ResponsiveBuilder(
            mobile: state.selectedConversationId != null ? ChatView(conversationId: state.selectedConversationId!) : const ConversationList(),
            desktop: Row(
              children: [
                const Expanded(
                  child: ConversationList(),
                ),
                Expanded(
                  flex: 2,
                  child: state.selectedConversationId == null
                      ? BlurredBackground(
                          radius: 0,
                          child: Center(
                            child: Text(
                              'Select a conversation to view messages',
                              style: context.textTheme.titleLarge?.copyWith(
                                color: AppColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : ChatView(conversationId: state.selectedConversationId!),
                ),
              ],
            ),
          );
        }
        if (state is ResetConversations) {
          return const SizedBox();
        }
        context.read<ConversationsBloc>().add(LoadConversations());
        return Scaffold(
          appBar: AppBar(
            title: const Text('Conversations'),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class ConversationList extends StatelessWidget {
  const ConversationList({super.key});

  void _showCreateConversationDialog(BuildContext context) {
    var controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) => DialogWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create Conversation',
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            InputField(
              controller: controller,
              hintText: 'Enter conversation name',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: AppButton(
                    label: 'Cancel',
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.primary,
                    onTap: context.pop,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: AppButton(
                    label: 'Create',
                    onTap: () {
                      if (controller.text.trim().isEmpty) {
                        return;
                      }
                      context.read<ConversationsBloc>().add(
                            CreateConversation(controller.text.trim()),
                          );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ConversationsBloc, ConversationsState>(
        builder: (context, state) {
          if (state is ConversationsLoaded) {
            return Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                title: const Text('Conversations'),
                backgroundColor: AppColors.primary,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout_rounded),
                    onPressed: () {
                      context.read<AuthBloc>().add(Logout());
                      context.read<ConversationsBloc>().add(ResetConversations());
                      context.go(AppRoutes.login);
                    },
                  ),
                ],
              ),
              body: state.conversations.isEmpty
                  ? const NoConversations()
                  : ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = state.conversations[index];
                        final isSelected = state.selectedConversationId == conversation.conversationId;
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          leading: CircleAvatar(
                            backgroundColor: isSelected ? AppColors.background : AppColors.primary,
                            child: Text(
                              (conversation.conversationName ?? 'U')[0].toUpperCase(),
                              style: context.textTheme.titleLarge?.copyWith(
                                color: isSelected ? AppColors.primary : AppColors.white,
                              ),
                            ),
                          ),
                          title: Text(conversation.conversationName ?? 'Unknown'),
                          subtitle: conversation.lastMessage != null
                              ? Text(
                                  '${conversation.lastMessage!.senderName}: ${conversation.lastMessage!.body}',
                                )
                              : null,
                          selected: isSelected,
                          selectedColor: AppColors.white,
                          selectedTileColor: AppColors.secondary,
                          onTap: () {
                            context.go(
                              AppRoutes.conversations,
                              extra: conversation.conversationId!,
                            );
                          },
                        );
                      },
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _showCreateConversationDialog(context);
                },
                child: const Icon(Icons.add),
              ),
            );
          }

          return const SizedBox();
        },
      );
}
