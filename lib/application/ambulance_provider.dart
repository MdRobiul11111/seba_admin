import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/domain/ambulance/ambulance_model.dart';
import 'package:seba_admin/domain/ambulance/i_ambulance_repo.dart';
import 'package:seba_admin/infrastructure/ambulance_repo.dart';

final ambulanceRepoProvider = FutureProvider<IAmbulanceRepo>((ref) async {
  return AmbulanceRepo();
});

final ambulanceListProvider = FutureProvider<IList<AmbulanceModel>>((
  ref,
) async {
  final repo = await ref.read(ambulanceRepoProvider.future);
  return repo.getAmbulances();
});
