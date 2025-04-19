import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:seba_admin/domain/ambulance/ambulance_model.dart';

abstract class IAmbulanceRepo {
  Future<IList<AmbulanceModel>> getAmbulances();
  Future<void> approveAmbulance({required AmbulanceModel ambulance});
  Future<void> deleteAmbulance({required String ambulanceId});
}
