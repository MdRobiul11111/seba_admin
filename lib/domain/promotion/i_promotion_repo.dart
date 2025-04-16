import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:seba_admin/domain/promotion/promotion_model.dart';

abstract class IPromotionRepo {
  Future<void> uploadPromotionImage({required String imagePath});
  Future<IList<PromotionModel>> getPromotion();
  Future<void> deletePromotion({required String id});
}
