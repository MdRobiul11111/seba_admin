import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:seba_admin/domain/notice/i_notice_repo.dart';
import 'package:seba_admin/domain/notice/notice_model.dart';

class NoticeRepo extends INoticeRepo {
  final collection = FirebaseFirestore.instance.collection('notices');

  @override
  Future<void> uploadNoticeImage({required String imagePath}) async {
    try {
      final String fileName =
          'notice_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef = FirebaseStorage.instance.ref().child(fileName);

      await storageRef.putFile(File(imagePath));

      final downloadUrl = await storageRef.getDownloadURL();
      final docRef = collection.doc();

      final data = NoticeModel(id: docRef.id, imgae: downloadUrl);
      await docRef.set(data.toMap());
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  @override
  Future<void> deleteNotice({required String id}) async {
    await collection.doc(id).delete();
  }

  @override
  Future<IList<NoticeModel>> getNotices() async {
    try {
      final QuerySnapshot snapshot = await collection.get();
      final data =
          snapshot.docs
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return NoticeModel.fromMap(data);
              })
              .toIList()
              .reversed;

      return data;
    } catch (e) {
      Logger().e(e.toString());
      return IList<NoticeModel>([]);
    }
  }
}
