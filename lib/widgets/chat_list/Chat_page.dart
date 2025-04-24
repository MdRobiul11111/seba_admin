import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seba_admin/application/chat_provider.dart';
import 'package:seba_admin/domain/chat/chat_model.dart';

class ChatPage extends HookConsumerWidget {
  final ChatModel chat;
  const ChatPage({super.key, required this.chat});

  @override
  Widget build(BuildContext context, ref) {
    final messageList = ref.watch(chatDetailsProvider(chat.senderId));
    final messageController = useTextEditingController();
    final isDownloading = useState(false);
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
                  chat.userName,
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
      body: Column(
        children: [
          Expanded(
            child: messageList.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (error, stackTrace) => Center(
                    child: Text(
                      "Error loading messages: $error",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              data: (data) {
                return ListView.builder(
                  reverse: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final message = data[index];
                    final dateTime = message.timestamp!;
                    final formattedTime =
                        "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
                    return Align(
                      alignment:
                          message.isAdmin
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              message.isAdmin ? Colors.green : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              message.isAdmin
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            message.type == "image"
                                ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (!message.isAdmin)
                                      InkWell(
                                        onTap: () async {
                                          isDownloading.value = true;
                                          var response = await Dio().get(
                                            message.content,
                                            options: Options(
                                              responseType: ResponseType.bytes,
                                            ),
                                          );
                                          await ImageGallerySaverPlus.saveImage(
                                            Uint8List.fromList(response.data),
                                            quality: 60,
                                            name: "hello",
                                          );
                                          isDownloading.value = false;

                                          if (context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Image Downloaded successfully!',
                                                ),
                                                backgroundColor: Color(
                                                  0xff008000,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child:
                                            isDownloading.value
                                                ? CircularProgressIndicator()
                                                : Icon(
                                                  Icons.download,
                                                  color: Colors.white,
                                                ),
                                      ),
                                    if (!message.isAdmin) SizedBox(width: 10),
                                    Image.network(
                                      message.content,
                                      width: 200,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) => Text(
                                            "Unable to load image",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                    ),
                                    if (message.isAdmin) SizedBox(width: 10),
                                    if (message.isAdmin)
                                      InkWell(
                                        onTap: () async {
                                          var response = await Dio().get(
                                            message.content,
                                            options: Options(
                                              responseType: ResponseType.bytes,
                                            ),
                                          );
                                          await ImageGallerySaverPlus.saveImage(
                                            Uint8List.fromList(response.data),
                                            quality: 60,
                                            name: "hello",
                                          );
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Image Downloaded successfully!',
                                                ),
                                                backgroundColor: Color(
                                                  0xff008000,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Icon(
                                          Icons.download,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
                                )
                                : Text(
                                  message.content,
                                  style: TextStyle(
                                    color:
                                        message.isAdmin
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                            SizedBox(height: 5),
                            Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    message.isAdmin
                                        ? Colors.white70
                                        : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: () async {
                    try {
                      final XFile? image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );

                      if (image == null) return; // User canceled the picker

                      // Show the image in a preview dialog with a send button
                      if (context.mounted) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return HookBuilder(
                              builder: (context) {
                                final loading = useState(false);
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.file(
                                        File(image.path),
                                        height: 300,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (!loading.value) {
                                            loading.value = true;
                                            try {
                                              String fileName =
                                                  'chat_${DateTime.now().millisecondsSinceEpoch}.jpg';

                                              final storageRef = FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                    'chat_images/${chat.senderId}/$fileName',
                                                  );

                                              await storageRef.putFile(
                                                File(image.path),
                                              );

                                              String downloadURL =
                                                  await storageRef
                                                      .getDownloadURL();

                                              final repo = await ref.read(
                                                chatRepoProvider.future,
                                              );
                                              final messageId =
                                                  '${DateTime.now().millisecondsSinceEpoch}_${1000 + (DateTime.now().microsecond % 9000)}';
                                              final message = ChatModel(
                                                senderId: chat.senderId,
                                                content: downloadURL,
                                                type: "image",
                                                isAdmin: true,
                                                timestamp: DateTime.now(),
                                                messageId: messageId,
                                                userName: chat.userName,
                                                receiverId: chat.receiverId,
                                                isRead: true,
                                              );

                                              await repo.sendMessage(
                                                message: message,
                                              );

                                              if (context.mounted) {
                                                Navigator.of(context).pop();
                                              }
                                            } catch (e) {
                                              if (context.mounted) {
                                                Navigator.of(context).pop();

                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "Error uploading image: $e",
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                            loading.value = false;
                                          }
                                        },
                                        child:
                                            loading.value
                                                ? const CircularProgressIndicator()
                                                : const Text('Send'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error picking image: $e")),
                        );
                      }
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (value) {
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed:
                      messageController.text.isNotEmpty
                          ? () async {
                            final repo = await ref.read(
                              chatRepoProvider.future,
                            );
                            final messageId =
                                '${DateTime.now().millisecondsSinceEpoch}_${1000 + (DateTime.now().microsecond % 9000)}';
                            final message = ChatModel(
                              senderId: chat.senderId,
                              content: messageController.text,
                              type: "text",
                              isAdmin: true,
                              timestamp: DateTime.now(),
                              messageId: messageId,
                              userName: chat.userName,
                              receiverId: chat.receiverId,
                              isRead: true,
                            );

                            await repo.sendMessage(message: message);
                            messageController.clear();
                          }
                          : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
