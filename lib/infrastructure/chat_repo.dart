import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:seba_admin/domain/chat/chat_model.dart';
import 'package:seba_admin/domain/chat/i_chat_repo.dart';

class ChatRepo extends IChatRepo {
  final chatCollection = FirebaseFirestore.instance.collection('Chat');
  final indiChatCollection = FirebaseFirestore.instance.collection('Indi_Chat');

  @override
  Stream<IList<ChatModel>> getUserList() {
    final steamData = chatCollection
        .orderBy("timestamp", descending: true)
        .snapshots()
        .asyncMap((event) async {
          final chats = await Future.wait(
            event.docs.map((doc) async {
              final data = doc.data();
              final chat = ChatModel.fromMap(data);

              final userImage = await getUserImage(chat.senderId);

              return chat.copyWith(imageUrl: userImage);
            }).toList(),
          );
          return chats.lock;
        });
    return steamData;
  }

  Future<String> getUserImage(String id) async {
    final doc =
        await FirebaseFirestore.instance
            .collection('user_images')
            .doc(id)
            .get();
    if (doc.exists && doc.data() != null) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // If imageUrl exists, set it to state
      if (data.containsKey('imageUrl') && data['imageUrl'] != null) {
        return data['imageUrl'];
      } else {
        return '';
      }
    }
    return '';
  }

  @override
  Future<void> sendMessage({required ChatModel message}) async {
    await chatCollection.doc(message.senderId).set(message.toMap());
    await indiChatCollection
        .doc(message.senderId)
        .collection('messages')
        .add(message.toMap());
  }

  @override
  Stream<IList<ChatModel>> getUserDetailsChat({required String userId}) {
    final steamData = indiChatCollection
        .doc(userId)
        .collection('messages')
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (event) =>
              event.docs
                  .map((doc) {
                    final data = doc.data();
                    return ChatModel.fromMap(data);
                  })
                  .toList()
                  .lock,
        );
    return steamData;
  }

  @override
  Future<void> markAsRead({required ChatModel message}) async {
    await chatCollection.doc(message.senderId).set(message.toMap());
  }

  @override
  Future<void> deleteChat({required String userId}) async {
    await chatCollection.doc(userId).delete();
    await indiChatCollection.doc(userId).delete();
  }
}
