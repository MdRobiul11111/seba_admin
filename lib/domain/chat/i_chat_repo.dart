import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:seba_admin/domain/chat/chat_model.dart';

abstract class IChatRepo {
  Future<void> sendMessage({required ChatModel message});
  Stream<IList<ChatModel>> getUserList();
  Stream<IList<ChatModel>> getUserDetailsChat({required String userId});
}
