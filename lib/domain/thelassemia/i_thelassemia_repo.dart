import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:seba_admin/domain/thelassemia/thelassemia_model.dart';

abstract class IThelassemiaRepo {
  Future<IList<ThelassemiaModel>> getThelassemia();
  Future<void> approve({required ThelassemiaModel patient});
  Future<void> delete({required String id});
}
