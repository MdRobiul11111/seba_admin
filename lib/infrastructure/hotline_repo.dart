import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seba_admin/domain/hotline/hotline_model.dart';
import 'package:seba_admin/domain/hotline/i_hotline_repo.dart';

class HotlineRepo extends IHotlineRepo {
  final collection = FirebaseFirestore.instance.collection('hotlines');
  final docName = 'hotline';
  @override
  Future<HotlineModel> getHotlines() async {
    final quarySnapshot = await collection.doc(docName).get();

    if (quarySnapshot.data() != null) {
      final data = quarySnapshot.data() as Map<String, dynamic>;
      return HotlineModel.fromMap(data);
    } else {
      return HotlineModel.empty();
    }
  }

  @override
  Future<void> updateHotline({required HotlineModel hotline}) async {
    await collection.doc(docName).set(hotline.toMap());
  }
}
