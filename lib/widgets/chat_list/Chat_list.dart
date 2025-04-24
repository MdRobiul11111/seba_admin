import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/application/chat_provider.dart';
import 'package:seba_admin/widgets/chat_list/Chat_page.dart';

class ChatList extends HookConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final chatList = ref.watch(chatListProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff008000),
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 80,
          width: double.infinity,

          child: Center(
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    height: 33,
                    width: 33,
                    child: Image.asset('assets/back.png', fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "Chat",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 28,
                  width: 33,
                  child: Image.asset('assets/menu_10977681.png'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: chatList.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final chat = data[index];

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      GestureDetector(
                        onLongPressStart: (details) async {
                          final selected = await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                            ),
                            items: [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          );

                          if (selected != null) {
                            final repo = await ref.read(
                              chatRepoProvider.future,
                            );
                            await repo.deleteChat(userId: chat.senderId);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Chat Deleted!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(chat: chat),
                            ),
                          );
                          if (!chat.isRead) {
                            final repo = await ref.read(
                              chatRepoProvider.future,
                            );
                            repo.markAsRead(
                              message: chat.copyWith(isRead: true),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 55,
                                width: 55,
                                child: CircleAvatar(
                                  child: CachedNetworkImage(
                                    imageUrl: chat.imageUrl ?? '',
                                    placeholder:
                                        (context, url) =>
                                            Image.asset("assets/woman.png"),
                                    errorWidget:
                                        (context, s, o) =>
                                            Image.asset("assets/woman.png"),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chat.userName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    chat.type == 'text'
                                        ? chat.content
                                        : 'Sent an image',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          chat.isRead
                                              ? Colors.grey
                                              : Colors.black,
                                      fontWeight:
                                          chat.isRead ? null : FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
