import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:logger/logger.dart';
import 'package:seba_admin/domain/thelassemia/i_thelassemia_repo.dart';
import 'package:seba_admin/domain/thelassemia/thelassemia_model.dart';

class ThelassemiaRepo extends IThelassemiaRepo {
  @override
  Future<IList<ThelassemiaModel>> getThelassemia() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Thelasmia').get();
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
}
