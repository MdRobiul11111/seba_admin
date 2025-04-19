import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/domain/representive/i_representive_repo.dart';
import 'package:seba_admin/domain/representive/representive_code_model.dart';
import 'package:seba_admin/domain/representive/representive_model.dart';
import 'package:seba_admin/infrastructure/representive_repo.dart';

final representiveRepoProvider = FutureProvider<IRepresentiveRepo>((ref) async {
  return RepresentiveRepo();
});

final representiveCodeListProvider =
    FutureProvider<IList<RepresentiveCodeModel>>((ref) async {
      final repo = await ref.read(representiveRepoProvider.future);
      return repo.getRepresentiveCodeList();
    });

final representiveListProvider = FutureProvider<IList<RepresentiveModel>>((
  ref,
) async {
  final repo = await ref.read(representiveRepoProvider.future);
  return repo.getRepresentiveList();
});
