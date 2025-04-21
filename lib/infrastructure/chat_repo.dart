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
}
