import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/domain/promotion/i_promotion_repo.dart';
import 'package:seba_admin/domain/promotion/promotion_model.dart';
import 'package:seba_admin/infrastructure/promotion_repo.dart';

final promotionRepoProvider = FutureProvider<IPromotionRepo>((ref) async {
  return PromotionRepo();
});

final promotionListProvider = FutureProvider<IList<PromotionModel>>((
  ref,
) async {
  final repo = await ref.read(promotionRepoProvider.future);
  return repo.getPromotion();
});
