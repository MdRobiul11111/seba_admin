import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/domain/thelassemia/i_thelassemia_repo.dart';
import 'package:seba_admin/domain/thelassemia/thelassemia_model.dart';
import 'package:seba_admin/infrastructure/thelassemia_repo.dart';

final thelassemiaRepoProvider = FutureProvider<IThelassemiaRepo>((ref) async {
  return ThelassemiaRepo();
});

final thelassemiaListProvider = FutureProvider<IList<ThelassemiaModel>>((
  ref,
) async {
  final repo = await ref.read(thelassemiaRepoProvider.future);
  return repo.getThelassemia();
});
