import 'package:seba_admin/domain/hotline/hotline_model.dart';

abstract class IHotlineRepo {
  Future<HotlineModel> getHotlines();
  Future<void> updateHotline({required HotlineModel hotline});
}
