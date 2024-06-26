import 'package:chat_assignment/blocs/blocs.dart';
import 'package:chat_assignment/models/models.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:chat_assignment/views/views.dart';
import 'package:chat_assignment/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();
  late WebSocketChannel channel;

  final Uuid _uuid = const Uuid();

  bool sentMessage = false;

  void setup() async {
    final wsUrl = Uri.parse('https://echo.websocket.org/.ws');
    channel = WebSocketChannel.connect(wsUrl);

    await channel.ready;

    channel.stream.listen((event) {
      if (event is! String) {
        return;
      }
      if (!sentMessage) {
        return;
      }
      context.read<ChatBloc>().add(
            ReceiveMessage(
              MessageModel(
                conversationId: widget.conversationId,
                messageId: _uuid.v4(),
                body: event,
                sendByMe: false,
                sentAt: DateTime.now(),
              ),
            ),
          );
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) {
      return;
    }
    final message = SendMessage(
      conversationId: widget.conversationId,
      body: _controller.text,
    );
    sentMessage = true;
    channel.sink.add(_controller.text);
    context.read<ChatBloc>().add(message);
    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  void dispose() {
    channel.sink.close(status.normalClosure);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(LoadMessages(widget.conversationId));
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) => BlurredBackground(
        radius: 0,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => context.read<ConversationsBloc>().add(UnselectConversation()),
              color: AppColors.primary,
            ),
            title: Text(
              'Chat',
              style: context.theme.appBarTheme.titleTextStyle?.copyWith(
                color: AppColors.primary,
              ),
            ),
            centerTitle: false,
            backgroundColor: AppColors.background,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ChatLoaded) {
                      return ListView.separated(
                        itemCount: state.messages.length,
                        padding: const EdgeInsets.all(16),
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, index) {
                          final message = state.messages[index];
                          return MessageTile(message);
                          // return ListTile(
                          //   title: Text(message.body),
                          //   subtitle: Text(message.sentAt.toString()),
                          // );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              ColoredBox(
                color: AppColors.background,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputField(
                    controller: _controller,
                    hintText: 'Type a message',
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: AppColors.primary,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
