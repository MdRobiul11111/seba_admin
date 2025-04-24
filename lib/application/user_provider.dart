import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/domain/user/i_user_repo.dart';
import 'package:seba_admin/domain/user/user_model.dart';
import 'package:seba_admin/infrastructure/user_repo.dart';

final userRepoProvider = FutureProvider<IUserRepo>((ref) async {
  return UserRepo();
});

final userListProvider = FutureProvider<IList<UserModel>>((ref) async {
  final repo = await ref.read(userRepoProvider.future);
  return repo.getAllUsers();
});
