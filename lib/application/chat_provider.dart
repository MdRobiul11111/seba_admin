import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/domain/chat/i_chat_repo.dart';
import 'package:seba_admin/infrastructure/chat_repo.dart';

final chatRepoProvider = FutureProvider<IChatRepo>((ref) async {
  return ChatRepo();
});

final chatListProvider = StreamProvider.autoDispose((ref) async* {
  final repo = await ref.read(chatRepoProvider.future);
  yield* repo.getUserList();
});

final chatDetailsProvider = StreamProvider.autoDispose.family((
  ref,
  String userId,
) async* {
  final repo = await ref.read(chatRepoProvider.future);
  yield* repo.getUserDetailsChat(userId: userId);
});
