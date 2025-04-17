import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/domain/hotline/hotline_model.dart';
import 'package:seba_admin/domain/hotline/i_hotline_repo.dart';
import 'package:seba_admin/infrastructure/hotline_repo.dart';

final hotlineRepoProvider = FutureProvider<IHotlineRepo>((ref) async {
  return HotlineRepo();
});

final hotlineListProvider = FutureProvider<HotlineModel>((ref) async {
  final repo = await ref.read(hotlineRepoProvider.future);
  return repo.getHotlines();
});
