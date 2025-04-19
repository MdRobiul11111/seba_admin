import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:logger/logger.dart';
import 'package:seba_admin/domain/ambulance/ambulance_model.dart';
import 'package:seba_admin/domain/ambulance/i_ambulance_repo.dart';

class AmbulanceRepo extends IAmbulanceRepo {
  final collection = FirebaseFirestore.instance.collection(
    'AmbulanceDatabase_temp',
  );
  @override
  Future<IList<AmbulanceModel>> getAmbulances() async {
    try {
      final QuerySnapshot snapshot = await collection.get();
      final data =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return AmbulanceModel.fromMap(data);
          }).toIList();

      return data;
    } catch (e) {
      Logger().e(e.toString());
      return IList<AmbulanceModel>([]);
    }
  }

  @override
  Future<void> approveAmbulance({required AmbulanceModel ambulance}) async {
    await collection
        .doc("${ambulance.license}@gmail.com")
        .set(ambulance.copyWith(approved: true).toMap());
  }

  @override
  Future<void> deleteAmbulance({required String ambulanceId}) async {
    await collection.doc("$ambulanceId@gmail.com").delete();
  }
}
