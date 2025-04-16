import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/domain/notice/i_notice_repo.dart';
import 'package:seba_admin/domain/notice/notice_model.dart';
import 'package:seba_admin/infrastructure/notice_repo.dart';

final noticeRepoProvider = FutureProvider<INoticeRepo>((ref) async {
  return NoticeRepo();
});

final noticeListProvider = FutureProvider<IList<NoticeModel>>((ref) async {
  final repo = await ref.read(noticeRepoProvider.future);
  return repo.getNotices();
});
