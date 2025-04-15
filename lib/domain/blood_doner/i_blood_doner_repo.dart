import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:seba_admin/domain/blood_doner/blood_doner_model.dart';

abstract class IBloodDonerRepo {
  Future<IList<BloodDonerModel>> getBloodDoners();
}
