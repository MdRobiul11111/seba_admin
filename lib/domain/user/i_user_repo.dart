import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:seba_admin/domain/user/user_model.dart';

abstract class IUserRepo {
  Future<void> deleteUser({
    required String userId,
    required BuildContext context,
  });
  Future<IList<UserModel>> getAllUsers();
}
