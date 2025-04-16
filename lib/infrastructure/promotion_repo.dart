import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:seba_admin/domain/promotion/i_promotion_repo.dart';
import 'package:seba_admin/domain/promotion/promotion_model.dart';

class PromotionRepo extends IPromotionRepo {
  final collection = FirebaseFirestore.instance.collection('promotions');

  @override
  Future<void> deletePromotion({required String id}) async {
    await collection.doc(id).delete();
  }

  @override
  Future<IList<PromotionModel>> getPromotion() async {
    try {
      final QuerySnapshot snapshot = await collection.get();
      final data =
          snapshot.docs
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return PromotionModel.fromMap(data);
              })
              .toIList()
              .reversed;

      return data;
    } catch (e) {
      Logger().e(e.toString());
      return IList<PromotionModel>([]);
    }
  }

  @override
  Future<void> uploadPromotionImage({required String imagePath}) async {
    try {
      final String fileName =
          'promotion_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef = FirebaseStorage.instance.ref().child(fileName);

      await storageRef.putFile(File(imagePath));

      final downloadUrl = await storageRef.getDownloadURL();
      final docRef = collection.doc();

      final data = PromotionModel(id: docRef.id, imgae: downloadUrl);
      await docRef.set(data.toMap());
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
