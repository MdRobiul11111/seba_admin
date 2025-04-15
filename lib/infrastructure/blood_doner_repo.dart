import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:logger/logger.dart';
import 'package:seba_admin/domain/blood_doner/blood_doner_model.dart';
import 'package:seba_admin/domain/blood_doner/i_blood_doner_repo.dart';

class BloodDonerRepo extends IBloodDonerRepo {
  @override
  Future<IList<BloodDonerModel>> getBloodDoners() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Donation').get();
      final data =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return BloodDonerModel.fromMap(data);
          }).toIList();

      return data;
    } catch (e) {
      Logger().e(e.toString());
      return IList<BloodDonerModel>([]);
    }
  }
}
