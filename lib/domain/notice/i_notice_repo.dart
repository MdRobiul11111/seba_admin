import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:seba_admin/domain/notice/notice_model.dart';

abstract class INoticeRepo {
  Future<void> uploadNoticeImage({required String imagePath});
  Future<IList<NoticeModel>> getNotices();
  Future<void> deleteNotice({required String id});
}
