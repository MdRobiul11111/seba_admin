import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:logger/logger.dart';
import 'package:seba_admin/domain/thelassemia/i_thelassemia_repo.dart';
import 'package:seba_admin/domain/thelassemia/thelassemia_model.dart';

class ThelassemiaRepo extends IThelassemiaRepo {
  final collection = FirebaseFirestore.instance.collection('Thelasmia');
  @override
  Future<IList<ThelassemiaModel>> getThelassemia() async {
    try {
      final QuerySnapshot snapshot = await collection.get();
      final data =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return ThelassemiaModel.fromMap(data);
          }).toIList();

      return data;
    } catch (e) {
      Logger().e(e.toString());
      return IList<ThelassemiaModel>([]);
    }
  }

  @override
  Future<void> approve({required ThelassemiaModel patient}) async {
    await collection
        .doc("${patient.nid}@gmail.com")
        .set(patient.copyWith(approved: true).toMap());
  }

  @override
  Future<void> delete({required String id}) async {
    await collection.doc("$id@gmail.com").delete();
  }
}
