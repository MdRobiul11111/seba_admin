import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:seba_admin/domain/user/i_user_repo.dart';
import 'package:seba_admin/domain/user/user_model.dart';

class UserRepo extends IUserRepo {
  final userCollection = FirebaseFirestore.instance.collection('UserRegress');

  final passCollection = FirebaseFirestore.instance.collection('Users');

  @override
  Future<IList<UserModel>> getAllUsers() async {
    try {
      final snapshot = await userCollection.get();
      Logger().d(snapshot.docs.length);
      final data =
          snapshot.docs
              .map((doc) {
                final data = doc.data();
                final id = doc.id;
                final rep = UserModel.fromMap(data);
                return rep.copyWith(uid: id);
              })
              .toIList()
              .reversed;

      return data;
    } catch (e) {
      Logger().e(e.toString());
      return IList<UserModel>([]);
    }
  }

  @override
  Future<void> deleteUser({
    required String userId,
    required BuildContext context,
  }) async {
    try {
      final passColl = await passCollection.doc(userId).get();
      final password = passColl.data()!['password'];
      Logger().f(password);
      final fireabaseAuth = FirebaseAuth.instance;
      await fireabaseAuth.signInWithEmailAndPassword(
        email: userId,
        password: password,
      );
      final user = fireabaseAuth.currentUser;
      Logger().d(user?.uid);
      await user?.delete();
      await userCollection.doc(userId).delete();
      await passCollection.doc(userId).delete();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User Deleted!'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      Logger().e(e.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting user'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
