import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/domain/blood_doner/blood_doner_model.dart';
import 'package:seba_admin/domain/blood_doner/i_blood_doner_repo.dart';
import 'package:seba_admin/infrastructure/blood_doner_repo.dart';

final bloodDonerRepoProvider = FutureProvider<IBloodDonerRepo>((ref) async {
  return BloodDonerRepo();
});

final bloodDonerListProvider = FutureProvider<IList<BloodDonerModel>>((
  ref,
) async {
  final repo = await ref.read(bloodDonerRepoProvider.future);
  return repo.getBloodDoners();
});
